#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the diff for SPEC.md (compare trusted base against PR head)
DIFF=$(git diff "HEAD...$HEAD_SHA" -- SPEC.md)

if [ -z "$DIFF" ]; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "No changes to SPEC.md found in this PR — nothing to review against contribution guidelines."
  exit 0
fi

# Build the LLM request — inject live CONTRIBUTING.md into the prompt template
REPO_ROOT="$(git rev-parse --show-toplevel)"
CONTRIBUTING=$(cat "$REPO_ROOT/CONTRIBUTING.md")
PROMPT_TEMPLATE=$(cat "$SCRIPT_DIR/contribution-review-prompt.md")
SYSTEM_PROMPT="${PROMPT_TEMPLATE/\{\{CONTRIBUTING_MD\}\}/$CONTRIBUTING}"
USER_PROMPT=$(printf 'Please review this SPEC.md diff:\n\n```diff\n%s\n```' "$DIFF")

export SYSTEM_PROMPT
export USER_PROMPT

# Call Claude with tool-calling support (fetch_webpage tool)
LLM_STDERR=$(mktemp)
if ! REVIEW=$(python3 "$SCRIPT_DIR/llm_with_tools.py" 2>"$LLM_STDERR"); then
  ERR=$(cat "$LLM_STDERR")
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "$(printf '❌ Review failed:\n\n```\n%s\n```' "$ERR")"
  exit 1
fi

if [ -z "$REVIEW" ]; then
  echo "Error: No review content in response"
  exit 1
fi

# Post the review as a PR comment
gh pr comment "$PR_NUMBER" --repo "$REPO" --body "$REVIEW"
