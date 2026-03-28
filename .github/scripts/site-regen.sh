#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Read SPEC.md and index.html from the PR head using git show.
# The working directory remains the trusted base branch throughout — we never
# check out PR code.
SPEC=$(git show "$HEAD_SHA:SPEC.md")
CURRENT_HTML=$(git show "$HEAD_SHA:index.html")

# Build prompts for the LLM
export SYSTEM_PROMPT="You are a web developer maintaining the AI4JVM website (a single-page HTML + inline CSS site, no build step). Your task is to update index.html so it exactly matches the provided SPEC.md. Preserve existing structure, styles, and inline CSS unless the spec requires changes. You may use the fetch_webpage tool to look up any URLs mentioned in SPEC.md if you need more context. Return ONLY the complete updated index.html file — no explanation, no markdown code fences."
export USER_PROMPT="Current index.html:

$CURRENT_HTML

Update the above to match this SPEC.md:

$SPEC

Return ONLY the complete updated index.html."
export MAX_TOKENS=100000
export MODEL=openai/gpt-4.1

# Call GitHub Models with tool-calling support (fetch_webpage tool)
NEW_HTML=$(python3 "$SCRIPT_DIR/llm_with_tools.py")

if [ -z "$NEW_HTML" ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Site regeneration failed: no content returned from the model."
  exit 1
fi

# Strip markdown code fences if the model wrapped the output in them
NEW_HTML=$(echo "$NEW_HTML" | sed '/^```.*$/d')

# Store the regenerated content as a git blob object
NEW_BLOB=$(printf '%s\n' "$NEW_HTML" | git hash-object -w --stdin)

# Check whether index.html actually changed
OLD_BLOB=$(git ls-tree "$HEAD_SHA" -- index.html | awk '{print $3}')

if [ "$OLD_BLOB" = "$NEW_BLOB" ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "ℹ️ No changes to \`index.html\` — the site is already up to date with \`SPEC.md\`."
  exit 0
fi

# Build a new commit directly on top of the PR head without checking out the
# PR branch, using git plumbing commands.
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

NEW_TREE=$(git ls-tree "$HEAD_SHA" | \
  awk -v blob="$NEW_BLOB" '/\tindex\.html$/{printf "100644 blob %s\tindex.html\n", blob; next} {print}' | \
  git mktree)
NEW_COMMIT=$(git commit-tree "$NEW_TREE" -p "$HEAD_SHA" -m "regen: update index.html from SPEC.md")

git push origin "$NEW_COMMIT:refs/heads/$HEAD_REF"

gh pr comment "$PR_NUMBER" --repo "$REPO" \
  --body "✅ Site regenerated and pushed to this PR branch."
