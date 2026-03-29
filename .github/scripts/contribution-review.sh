#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(git rev-parse --show-toplevel)"

# Get the diff for SPEC.md (compare trusted base against PR head)
DIFF=$(git diff "HEAD...$HEAD_SHA" -- SPEC.md)

if [ -z "$DIFF" ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "No changes to SPEC.md found in this PR — nothing to review against contribution guidelines."
  exit 0
fi

# Write the diff to a file Claude can read
DIFF_FILE=$(mktemp "$REPO_ROOT/spec-diff-XXXXXX.patch")
printf '%s' "$DIFF" > "$DIFF_FILE"

# Build the system prompt — inject live CONTRIBUTING.md into the prompt template
CONTRIBUTING=$(cat "$REPO_ROOT/CONTRIBUTING.md")
PROMPT_TEMPLATE=$(cat "$SCRIPT_DIR/contribution-review-prompt.md")
SYSTEM_PROMPT="${PROMPT_TEMPLATE/\{\{CONTRIBUTING_MD\}\}/$CONTRIBUTING}"

# Write the review to a file instead of capturing stdout
REVIEW_FILE=$(mktemp "$REPO_ROOT/review-XXXXXX.md")

PROMPT="Read the SPEC.md diff in $(basename "$DIFF_FILE") and review it according to the contribution guidelines.

Write your review to $(basename "$REVIEW_FILE"). Use the WebFetch tool to verify every URL in the contribution. Do not modify any other files."

LLM_STDERR=$(mktemp)
if ! claude -p "$PROMPT" \
  --system-prompt "$SYSTEM_PROMPT" \
  --allowedTools "Read,Write,Edit,WebFetch,WebSearch" \
  --model claude-opus-4-6 \
  --max-turns 30 \
  2>"$LLM_STDERR"; then
  ERR=$(tail -c 3000 "$LLM_STDERR")
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "$(printf '❌ Review failed:\n\n```\n%s\n```' "$ERR")"
  rm -f "$DIFF_FILE" "$REVIEW_FILE"
  exit 1
fi

rm -f "$DIFF_FILE"

REVIEW=$(cat "$REVIEW_FILE")
rm -f "$REVIEW_FILE"

if [ -z "$REVIEW" ]; then
  echo "Error: No review content produced"
  exit 1
fi

# Post the review as a PR comment
gh pr comment "$PR_NUMBER" --repo "$REPO" --body "$REVIEW"
