#!/usr/bin/env python3
"""
LLM inference with tool calling via Anthropic Claude API.

Reads the following environment variables:
  ANTHROPIC_API_KEY (required) Anthropic API key for authentication
  SYSTEM_PROMPT     (required) System prompt passed to the model
  USER_PROMPT       (required) User message passed to the model
  MODEL             (optional) Model identifier (default: claude-opus-4-6)
  MAX_TOKENS        (optional) Max tokens for the final answer (default: 16384)

Prints the final model response to stdout and exits non-zero on error.

Supported tools:
  fetch_webpage(url) - fetches a URL and returns stripped text content
  web_search(query) - searches the web via DuckDuckGo and returns results
"""

import json
import os
import sys
import urllib.error
import urllib.parse
import urllib.request
from html.parser import HTMLParser

API_URL = "https://api.anthropic.com/v1/messages"

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
# HTML -> plain-text helper
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


def web_search(query: str) -> str:
    """Search the web via DuckDuckGo HTML and return results."""
    try:
        encoded = urllib.parse.urlencode({"q": query})
        req = urllib.request.Request(
            f"https://html.duckduckgo.com/html/?{encoded}",
            headers={"User-Agent": "Mozilla/5.0 (compatible; AI4JVM-reviewer/1.0)"},
        )
        with urllib.request.urlopen(req, timeout=_REQUEST_TIMEOUT) as resp:
            raw = resp.read(60_000).decode("utf-8", errors="replace")

        parser = _HTMLTextExtractor()
        parser.feed(raw)
        text = parser.get_text()
        return text[:_FETCH_MAX_TEXT] or "(no results)"
    except Exception as exc:
        return f"Error searching for '{query}': {exc}"


TOOLS = [
    {
        "name": "fetch_webpage",
        "description": (
            "Fetch and return the text content of a webpage. "
            "Use this to verify that URLs are reachable, confirm that a "
            "project exists, or gather current information about a library "
            "or tool."
        ),
        "input_schema": {
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
    {
        "name": "web_search",
        "description": (
            "Search the web for information. Returns a list of search "
            "results with titles, URLs, and snippets. Use this to find "
            "information about libraries, projects, or technologies."
        ),
        "input_schema": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "The search query",
                }
            },
            "required": ["query"],
        },
    },
]

_TOOL_HANDLERS = {
    "fetch_webpage": lambda args: fetch_webpage(args["url"]),
    "web_search": lambda args: web_search(args["query"]),
}


# ---------------------------------------------------------------------------
# API helper
# ---------------------------------------------------------------------------

def _api_call(messages: list, system: str, api_key: str, model: str,
              max_tokens: int, use_tools: bool) -> dict:
    payload: dict = {
        "model": model,
        "max_tokens": max_tokens,
        "system": system,
        "messages": messages,
    }
    if use_tools:
        payload["tools"] = TOOLS

    req = urllib.request.Request(
        API_URL,
        data=json.dumps(payload).encode(),
        headers={
            "Content-Type": "application/json",
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
        },
    )
    print(f"Using endpoint: {API_URL}", file=sys.stderr)
    print(f"Model: {model}", file=sys.stderr)
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
    api_key = os.environ["ANTHROPIC_API_KEY"]
    system_prompt = os.environ["SYSTEM_PROMPT"]
    user_prompt = os.environ["USER_PROMPT"]
    model = os.environ.get("MODEL", "claude-opus-4-6")
    max_tokens = int(os.environ.get("MAX_TOKENS", "16384"))

    messages: list[dict] = [
        {"role": "user", "content": user_prompt},
    ]

    for _ in range(_MAX_TOOL_ITERATIONS):
        response = _api_call(messages, system_prompt, api_key, model,
                             max_tokens, use_tools=True)

        stop_reason = response.get("stop_reason", "")
        content = response.get("content", [])

        # Check if there are any tool_use blocks
        tool_uses = [b for b in content if b.get("type") == "tool_use"]
        if not tool_uses:
            # Extract text from text blocks
            text_parts = [b["text"] for b in content if b.get("type") == "text"]
            return "\n".join(text_parts)

        # Append the assistant message with all content blocks
        messages.append({"role": "assistant", "content": content})

        # Execute each tool and build tool_result blocks
        tool_results = []
        for tc in tool_uses:
            fn_name = tc["name"]
            fn_args = tc["input"]
            tool_id = tc["id"]
            print(f"Tool call: {fn_name}({fn_args})", file=sys.stderr)
            handler = _TOOL_HANDLERS.get(fn_name)
            result = handler(fn_args) if handler else f"Unknown tool: {fn_name}"
            tool_results.append({
                "type": "tool_result",
                "tool_use_id": tool_id,
                "content": result,
            })

        messages.append({"role": "user", "content": tool_results})

    return f"Error: tool-call loop exceeded {_MAX_TOOL_ITERATIONS} iterations"


if __name__ == "__main__":
    print(run())
