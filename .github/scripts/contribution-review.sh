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

# Build the system prompt — inject live CONTRIBUTING.md into the prompt template
REPO_ROOT="$(git rev-parse --show-toplevel)"
CONTRIBUTING=$(cat "$REPO_ROOT/CONTRIBUTING.md")
PROMPT_TEMPLATE=$(cat "$SCRIPT_DIR/contribution-review-prompt.md")
SYSTEM_PROMPT="${PROMPT_TEMPLATE/\{\{CONTRIBUTING_MD\}\}/$CONTRIBUTING}"

SYSTEM_FILE=$(mktemp)
printf '%s' "$SYSTEM_PROMPT" > "$SYSTEM_FILE"

USER_PROMPT=$(printf 'Please review this SPEC.md diff:\n\n```diff\n%s\n```' "$DIFF")

# Call Claude Code CLI with web tools
LLM_STDERR=$(mktemp)
if ! REVIEW=$(claude -p "$USER_PROMPT" \
  --system-prompt-file "$SYSTEM_FILE" \
  --allowedTools "WebFetch,WebSearch" \
  --model claude-opus-4-6 \
  --max-turns 10 \
  --output-format text \
  2>"$LLM_STDERR"); then
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
