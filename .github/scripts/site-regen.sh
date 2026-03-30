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

# Merge base into PR head to get the most up-to-date index.html for editing.
# The actual regen commit will be parented on HEAD_SHA (not a merge).
if MERGED_TREE=$(git merge-tree --write-tree HEAD "$HEAD_SHA" 2>/dev/null); then
  MERGE_COMMIT=$(git commit-tree "$MERGED_TREE" -p "$HEAD_SHA" -p "$BASE_HEAD" \
    -m "Merge $BASE_REF into PR branch")
  git show "$MERGE_COMMIT:index.html" > "$REPO_ROOT/index.html"
else
  # Merge conflicts — use base's index.html (we're regenerating it anyway)
  git show "$BASE_HEAD:index.html" > "$REPO_ROOT/index.html"
fi
# Save a copy to detect changes
cp "$REPO_ROOT/index.html" "$REPO_ROOT/index.html.orig"

CURRENT_HTML=$(cat "$REPO_ROOT/index.html")

# Build the prompt with the current HTML and diff
PROMPT="You are a web developer maintaining a single-page HTML site.

Below is the current index.html followed by a SPEC.md diff. Update the HTML to reflect ONLY the changes in the diff.

For added items: create the corresponding HTML (cards, people, links, etc.) matching the existing style/structure. Insert in the correct position.
For removed items: delete the corresponding HTML block.
For modified items: update the corresponding HTML to match.

Rules:
- Do NOT modify any HTML comments.
- Do NOT change anything not affected by the diff.
- Output ONLY the complete updated HTML file — no explanations, no markdown fences, no commentary.
- The output must start with <!DOCTYPE html> and end with </html>.

## Current index.html

${CURRENT_HTML}

## SPEC.md Diff

\`\`\`diff
${SPEC_DIFF}
\`\`\`

Output the complete updated index.html now:"

OUTPUT_FILE=$(mktemp "$REPO_ROOT/output-XXXXXX.html")

if ! kiro-cli-chat chat --no-interactive "$PROMPT" 2>/dev/null > "$OUTPUT_FILE"; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: kiro-cli-chat returned an error."
  rm -f "$OUTPUT_FILE"
  exit 1
fi

NEW_HTML=$(cat "$OUTPUT_FILE")
rm -f "$OUTPUT_FILE"

# Validate the output
if [ ${#NEW_HTML} -lt 1000 ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: output is too small (${#NEW_HTML} bytes)."
  exit 1
fi

if ! echo "$NEW_HTML" | head -1 | grep -qi '<!DOCTYPE html>'; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: output does not start with <!DOCTYPE html>."
  exit 1
fi

# Write the validated output
printf '%s' "$NEW_HTML" > "$REPO_ROOT/index.html"

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

# Build the regen commit on top of HEAD_SHA (the PR tip) — NOT a merge commit.
NEW_TREE=$(git ls-tree "$HEAD_SHA" | \
  awk -v blob="$NEW_BLOB" '/\tindex\.html$/{printf "100644 blob %s\tindex.html\n", blob; next} {print}' | \
  git mktree)

NEW_COMMIT=$(git commit-tree "$NEW_TREE" -p "$HEAD_SHA" \
  -m "regen: update index.html from SPEC.md")

if [ "${IS_FORK:-false}" = "true" ]; then
  REGEN_BRANCH="regen/pr-$PR_NUMBER"
  BASE_OWNER="${REPO%%/*}"

  if [ -n "${MAINTAINER_PAT:-}" ]; then
    # Strategy 1: Push directly to fork.
    FORK_URL="https://x-access-token:${MAINTAINER_PAT}@github.com/${HEAD_REPO}.git"
    PUSH_ERR=$(mktemp)
    if git push --force "$FORK_URL" "$NEW_COMMIT:refs/heads/$HEAD_REF" 2>"$PUSH_ERR"; then
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
