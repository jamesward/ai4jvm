#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

BASE_HEAD=$(git rev-parse HEAD)

# Get the SPEC.md diff — this is what the PR changed
SPEC_DIFF=$(git diff "HEAD...$HEAD_SHA" -- SPEC.md)

if [ -z "$SPEC_DIFF" ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "ℹ️ No changes to \`SPEC.md\` found in this PR — nothing to regenerate."
  exit 0
fi

# Merge the base branch into the PR head so the regen commit is up-to-date
# and won't cause merge conflicts when the PR is merged.
if MERGED_TREE=$(git merge-tree --write-tree HEAD "$HEAD_SHA" 2>/dev/null); then
  MERGE_COMMIT=$(git commit-tree "$MERGED_TREE" -p "$HEAD_SHA" -p "$BASE_HEAD" \
    -m "Merge $BASE_REF into PR branch")
  REGEN_PARENT="$MERGE_COMMIT"
  REGEN_BASE_TREE="$MERGE_COMMIT"
else
  REGEN_PARENT="MERGE"
  REGEN_BASE_TREE="$BASE_HEAD"
fi

# Write the merged index.html to the working directory for Claude to edit
git show "$REGEN_BASE_TREE:index.html" > "$REPO_ROOT/index.html"
# Save a copy to detect changes
cp "$REPO_ROOT/index.html" "$REPO_ROOT/index.html.orig"

# Write the SPEC.md diff to a file Claude can reference
DIFF_FILE=$(mktemp "$REPO_ROOT/spec-diff-XXXXXX.patch")
printf '%s' "$SPEC_DIFF" > "$DIFF_FILE"

# Let Claude Code edit index.html directly
PROMPT="Read the SPEC.md diff in $(basename "$DIFF_FILE") and update index.html to reflect ONLY those changes.

For added items: create the corresponding HTML (cards, people, links, etc.) matching the existing style/structure in index.html. Insert in the correct position.
For removed items: delete the corresponding HTML block.
For modified items: update the corresponding HTML to match.

Rules:
- Do NOT modify any HTML comments.
- Do NOT change anything not affected by the diff.
- Use WebFetch to verify URLs for NEW items. If broken, add <!-- LINK CHECK: 404 --> next to the link.
- Only edit index.html. Do not create or modify any other files."

LLM_STDERR=$(mktemp)
if ! claude -p "$PROMPT" \
  --allowedTools "Read,Edit,WebFetch,WebSearch" \
  --model claude-opus-4-6 \
  --max-turns 30 \
  2>"$LLM_STDERR"; then
  ERR=$(tail -c 3000 "$LLM_STDERR")
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "$(printf '❌ Site regeneration failed:\n\n```\n%s\n```' "$ERR")"
  rm -f "$DIFF_FILE"
  exit 1
fi

rm -f "$DIFF_FILE"

NEW_HTML=$(cat "$REPO_ROOT/index.html")

# Validate the output
if [ ${#NEW_HTML} -lt 1000 ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: index.html is too small after editing (${#NEW_HTML} bytes)."
  exit 1
fi

if ! head -1 "$REPO_ROOT/index.html" | grep -qi '<!DOCTYPE html>'; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: index.html does not start with <!DOCTYPE html>."
  exit 1
fi

# Check if index.html actually changed
if diff -q "$REPO_ROOT/index.html" "$REPO_ROOT/index.html.orig" >/dev/null 2>&1; then
  rm -f "$REPO_ROOT/index.html.orig"
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "ℹ️ No changes to \`index.html\` — the site is already up to date with \`SPEC.md\`."
  exit 0
fi
rm -f "$REPO_ROOT/index.html.orig"

# Store the regenerated content as a git blob object
NEW_BLOB=$(cat "$REPO_ROOT/index.html" | git hash-object -w --stdin)

# Build the new tree: start from the merge/base tree and replace index.html
NEW_TREE=$(git ls-tree "$REGEN_BASE_TREE" | \
  awk -v blob="$NEW_BLOB" '/\tindex\.html$/{printf "100644 blob %s\tindex.html\n", blob; next} {print}' | \
  git mktree)

if [ "$REGEN_PARENT" = "MERGE" ]; then
  NEW_COMMIT=$(git commit-tree "$NEW_TREE" -p "$HEAD_SHA" -p "$BASE_HEAD" \
    -m "regen: update index.html from SPEC.md")
else
  NEW_COMMIT=$(git commit-tree "$NEW_TREE" -p "$REGEN_PARENT" \
    -m "regen: update index.html from SPEC.md")
fi

if [ "${IS_FORK:-false}" = "true" ]; then
  REGEN_BRANCH="regen/pr-$PR_NUMBER"
  BASE_OWNER="${REPO%%/*}"

  if [ -n "${MAINTAINER_PAT:-}" ]; then
    # Strategy 1: Push directly to fork. Build fork-safe commit from fork's
    # tree with only index.html replaced (avoids .github/ changes).
    FORK_TREE=$(git ls-tree "$HEAD_SHA" | \
      awk -v blob="$NEW_BLOB" '/\tindex\.html$/{printf "100644 blob %s\tindex.html\n", blob; next} {print}' | \
      git mktree)
    FORK_COMMIT=$(git commit-tree "$FORK_TREE" -p "$HEAD_SHA" \
      -m "regen: update index.html from SPEC.md")

    FORK_URL="https://x-access-token:${MAINTAINER_PAT}@github.com/${HEAD_REPO}.git"
    PUSH_ERR=$(mktemp)
    if git push --force "$FORK_URL" "$FORK_COMMIT:refs/heads/$HEAD_REF" 2>"$PUSH_ERR"; then
      gh pr comment "$PR_NUMBER" --repo "$REPO" \
        --body "✅ Site regenerated and pushed to this PR branch."
      exit 0
    else
      echo "Strategy 1 (push to fork) failed: $(cat "$PUSH_ERR")" >&2
    fi
  fi

  git push origin "$NEW_COMMIT:refs/heads/$REGEN_BRANCH" --force

  if [ -n "${MAINTAINER_PAT:-}" ]; then
    # Strategy 2: PR on fork (or reuse existing)
    EXISTING_PR=$(GH_TOKEN="$MAINTAINER_PAT" gh api "repos/${HEAD_REPO}/pulls?head=${BASE_OWNER}:${REGEN_BRANCH}&base=${HEAD_REF}&state=open" 2>/dev/null | jq -r '.[0].html_url // empty')
    if [ -n "$EXISTING_PR" ]; then
      gh pr comment "$PR_NUMBER" --repo "$REPO" \
        --body "✅ Site regenerated! The PR on your fork has been updated: ${EXISTING_PR}"
      exit 0
    fi
    GH_TOKEN="$MAINTAINER_PAT" gh api "repos/${HEAD_REPO}/pulls" \
      -f title="regen: update index.html from SPEC.md" \
      -f head="${BASE_OWNER}:${REGEN_BRANCH}" \
      -f base="$HEAD_REF" \
      -f body="Automated site regeneration from [PR #${PR_NUMBER}](https://github.com/${REPO}/pull/${PR_NUMBER}). Merge this to update your PR branch." \
      2>/dev/null \
    && {
      gh pr comment "$PR_NUMBER" --repo "$REPO" \
        --body "✅ Site regenerated! I've opened a PR on your fork with the updated \`index.html\` — merge it to update this PR."
      exit 0
    }
  fi

  # Strategy 3: PR to main (or reuse existing)
  EXISTING_PR=$(gh pr list --repo "$REPO" --head "$REGEN_BRANCH" --base main --state open --json url --jq '.[0].url' 2>/dev/null)
  if [ -n "$EXISTING_PR" ]; then
    gh pr comment "$PR_NUMBER" --repo "$REPO" \
      --body "✅ Site regenerated! The existing PR has been updated: ${EXISTING_PR}"
    exit 0
  fi
  PR_URL=$(gh pr create --repo "$REPO" \
    --head "$REGEN_BRANCH" \
    --base main \
    --title "regen: update index.html for PR #$PR_NUMBER" \
    --body "Automated site regeneration for #${PR_NUMBER}. This PR includes the SPEC.md changes and the regenerated \`index.html\`." \
    2>/dev/null) \
  && {
    gh pr comment "$PR_NUMBER" --repo "$REPO" \
      --body "✅ Site regenerated! Since I couldn't push to your fork, I've opened ${PR_URL} with the updated \`index.html\`."
    exit 0
  }

  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "✅ Site regenerated on [\`$REGEN_BRANCH\`](https://github.com/$REPO/tree/$REGEN_BRANCH). A maintainer can merge this after your PR lands."
else
  git push origin "$NEW_COMMIT:refs/heads/$HEAD_REF"

  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "✅ Site regenerated and pushed to this PR branch."
fi
