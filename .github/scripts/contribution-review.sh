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

# Write the diff to a file the agent can read
DIFF_FILE=$(mktemp "$REPO_ROOT/spec-diff-XXXXXX.patch")
printf '%s' "$DIFF" > "$DIFF_FILE"

# Build the system prompt — inject live CONTRIBUTING.md into the prompt template
CONTRIBUTING=$(cat "$REPO_ROOT/CONTRIBUTING.md")
PROMPT_TEMPLATE=$(cat "$SCRIPT_DIR/contribution-review-prompt.md")
SYSTEM_PROMPT="${PROMPT_TEMPLATE/\{\{CONTRIBUTING_MD\}\}/$CONTRIBUTING}"

# Write the review to a file instead of capturing stdout
REVIEW_FILE=$(mktemp "$REPO_ROOT/review-XXXXXX.md")

# Create a temporary kiro agent config
AGENT_DIR="$REPO_ROOT/.kiro/agents"
mkdir -p "$AGENT_DIR"
AGENT_NAME="contribution-reviewer"
AGENT_FILE="$AGENT_DIR/${AGENT_NAME}.json"

# Escape the system prompt for JSON
SYSTEM_PROMPT_JSON=$(printf '%s' "$SYSTEM_PROMPT" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')

cat > "$AGENT_FILE" <<AGENTEOF
{
  "name": "$AGENT_NAME",
  "prompt": $SYSTEM_PROMPT_JSON,
  "model": "claude-opus-4-6",
  "tools": ["read", "write", "edit", "web_fetch", "web_search"],
  "allowedTools": ["read", "write", "edit", "web_fetch", "web_search"]
}
AGENTEOF

PROMPT="Read the SPEC.md diff in $(basename "$DIFF_FILE") and review it according to the contribution guidelines.

Write your review to $(basename "$REVIEW_FILE"). Use the web_fetch tool to verify every URL in the contribution. Do not modify any other files."

LLM_STDERR=$(mktemp)
if ! kiro-cli chat --no-interactive --trust-all-tools \
  --agent "$AGENT_NAME" \
  "$PROMPT" \
  2>"$LLM_STDERR"; then
  ERR=$(tail -c 3000 "$LLM_STDERR")
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "$(printf '❌ Review failed:\n\n```\n%s\n```' "$ERR")"
  rm -f "$DIFF_FILE" "$REVIEW_FILE" "$AGENT_FILE"
  exit 1
fi

rm -f "$DIFF_FILE" "$AGENT_FILE"

REVIEW=$(cat "$REVIEW_FILE")
rm -f "$REVIEW_FILE"

if [ -z "$REVIEW" ]; then
  echo "Error: No review content produced"
  exit 1
fi

# Post the review as a PR comment
gh pr comment "$PR_NUMBER" --repo "$REPO" --body "$REVIEW"
