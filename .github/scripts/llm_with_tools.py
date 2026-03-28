#!/usr/bin/env python3
"""
LLM inference with tool calling via GitHub Models API.

Reads the following environment variables:
  GITHUB_TOKEN   (required) GitHub token used for API auth
  SYSTEM_PROMPT  (required) System prompt passed to the model
  USER_PROMPT    (required) User message passed to the model
  MODEL          (optional) Model identifier (default: openai/gpt-5)
  MAX_TOKENS     (optional) Max tokens for the final answer (default: 100000)

Prints the final model response to stdout and exits non-zero on error.

Supported tools:
  fetch_webpage(url) – fetches a URL and returns stripped text content
"""

import json
import os
import sys
import urllib.error
import urllib.request
from html.parser import HTMLParser

API_URL = "https://models.github.ai/inference/chat/completions"

# How many bytes to read from a fetched page before stripping HTML/truncating.
# Large enough to capture most useful content while avoiding huge payloads.
_FETCH_READ_BYTES = 40_000
# Maximum characters of extracted text returned to the model per tool call.
_FETCH_MAX_TEXT = 8_000
# Seconds to wait for a remote server to respond.
_REQUEST_TIMEOUT = 15
# Maximum number of tool-call rounds before giving up.
_MAX_TOOL_ITERATIONS = 10


# ---------------------------------------------------------------------------
# HTML → plain-text helper
# ---------------------------------------------------------------------------

class _HTMLTextExtractor(HTMLParser):
    def __init__(self):
        super().__init__()
        self._pieces: list[str] = []
        self._skip_depth = 0

    def handle_starttag(self, tag, attrs):
        if tag in ("script", "style"):
            self._skip_depth += 1

    def handle_endtag(self, tag):
        if tag in ("script", "style") and self._skip_depth > 0:
            self._skip_depth -= 1

    def handle_data(self, data):
        if self._skip_depth == 0:
            text = data.strip()
            if text:
                self._pieces.append(text)

    def get_text(self) -> str:
        return "\n".join(self._pieces)


# ---------------------------------------------------------------------------
# Tool implementation
# ---------------------------------------------------------------------------

def fetch_webpage(url: str) -> str:
    """Fetch a URL and return cleaned text content (truncated to ~8 KB)."""
    try:
        req = urllib.request.Request(
            url,
            headers={"User-Agent": "Mozilla/5.0 (compatible; AI4JVM-reviewer/1.0)"},
        )
        with urllib.request.urlopen(req, timeout=_REQUEST_TIMEOUT) as resp:
            content_type = resp.headers.get("Content-Type", "")
            raw = resp.read(_FETCH_READ_BYTES).decode("utf-8", errors="replace")

        if "html" in content_type:
            parser = _HTMLTextExtractor()
            parser.feed(raw)
            text = parser.get_text()
        else:
            text = raw

        return text[:_FETCH_MAX_TEXT] or "(empty response)"
    except Exception as exc:
        return f"Error fetching {url}: {exc}"


TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "fetch_webpage",
            "description": (
                "Fetch and return the text content of a webpage. "
                "Use this to verify that URLs are reachable, confirm that a "
                "project exists, or gather current information about a library "
                "or tool."
            ),
            "parameters": {
                "type": "object",
                "properties": {
                    "url": {
                        "type": "string",
                        "description": "The full URL to fetch (e.g. https://example.com)",
                    }
                },
                "required": ["url"],
            },
        },
    }
]

_TOOL_HANDLERS = {"fetch_webpage": lambda args: fetch_webpage(args["url"])}


# ---------------------------------------------------------------------------
# API helper
# ---------------------------------------------------------------------------

def _api_call(messages: list, github_token: str, model: str,
              max_tokens: int, use_tools: bool) -> dict:
    payload: dict = {
        "model": model,
        "messages": messages,
        "max_tokens": max_tokens,
    }
    if use_tools:
        payload["tools"] = TOOLS
        payload["tool_choice"] = "auto"

    req = urllib.request.Request(
        API_URL,
        data=json.dumps(payload).encode(),
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {github_token}",
        },
    )
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as exc:
        body = exc.read().decode("utf-8", errors="replace")
        print(f"API error {exc.code}: {body}", file=sys.stderr)
        sys.exit(1)


# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------

def run() -> str:
    github_token = os.environ["GITHUB_TOKEN"]
    system_prompt = os.environ["SYSTEM_PROMPT"]
    user_prompt = os.environ["USER_PROMPT"]
    model = os.environ.get("MODEL", "openai/gpt-5")
    max_tokens = int(os.environ.get("MAX_TOKENS", "100000"))

    messages: list[dict] = [
        {"role": "system", "content": system_prompt},
        {"role": "user", "content": user_prompt},
    ]

    for _ in range(_MAX_TOOL_ITERATIONS):  # guard against infinite tool-call loops
        response = _api_call(messages, github_token, model, max_tokens,
                             use_tools=True)
        choice = response["choices"][0]
        msg = choice["message"]

        tool_calls = msg.get("tool_calls") or []
        if not tool_calls:
            return msg.get("content") or ""

        # Keep the assistant message (with tool_calls) in history
        messages.append(msg)

        # Execute each requested tool and append the results
        for tc in tool_calls:
            fn_name = tc["function"]["name"]
            fn_args = json.loads(tc["function"]["arguments"])
            handler = _TOOL_HANDLERS.get(fn_name)
            result = handler(fn_args) if handler else f"Unknown tool: {fn_name}"
            messages.append({
                "role": "tool",
                "tool_call_id": tc["id"],
                "content": result,
            })

    return f"Error: tool-call loop exceeded {_MAX_TOOL_ITERATIONS} iterations"


if __name__ == "__main__":
    print(run())
