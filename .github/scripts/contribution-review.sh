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

# Build the full prompt — inject CONTRIBUTING.md and diff into the prompt template
CONTRIBUTING=$(cat "$REPO_ROOT/CONTRIBUTING.md")
PROMPT_TEMPLATE=$(cat "$SCRIPT_DIR/contribution-review-prompt.md")
SYSTEM_PROMPT="${PROMPT_TEMPLATE/\{\{CONTRIBUTING_MD\}\}/$CONTRIBUTING}"

PROMPT="${SYSTEM_PROMPT}

---

## SPEC.md Diff to Review

\`\`\`diff
${DIFF}
\`\`\`

Review this diff according to the contribution guidelines above."

REVIEW_FILE=$(mktemp "$REPO_ROOT/review-XXXXXX.md")

if ! kiro-cli-chat chat --no-interactive "$PROMPT" 2>/dev/null > "$REVIEW_FILE"; then
  gh pr comment "$PR_NUMBER" --repo "$REPO" \
    --body "❌ Review failed: kiro-cli-chat returned an error."
  rm -f "$REVIEW_FILE"
  exit 1
fi

REVIEW=$(cat "$REVIEW_FILE")
rm -f "$REVIEW_FILE"

if [ -z "$REVIEW" ]; then
  echo "Error: No review content produced"
  exit 1
fi

# Post the review as a PR comment
gh pr comment "$PR_NUMBER" --repo "$REPO" --body "$REVIEW"
