#!/usr/bin/env python3
"""Structural checks for the generated ai4jvm.com files. Used by CI and the maintenance routine.

    python3 .factory/check-site.py

Fails (exit 1) on errors; prints warnings for things a human or the routine should look at.
Content quality (policy, links, descriptions) is judged by the maintenance routine, not here.
"""
import datetime
import json
import re
import sys
import xml.etree.ElementTree as ET
from html.parser import HTMLParser
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
errors, warnings = [], []


class Collector(HTMLParser):
    VOID = {"area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "source", "track", "wbr"}

    def __init__(self):
        super().__init__()
        self.stack, self.ld, self.in_ld, self.ids, self.hrefs = [], [], False, [], []

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if a.get("id"):
            self.ids.append(a["id"])
        if tag == "a" and a.get("href"):
            self.hrefs.append(a["href"])
        if tag == "script" and a.get("type") == "application/ld+json":
            self.in_ld = True
            self.ld.append("")
        if tag not in self.VOID:
            self.stack.append((tag, self.getpos()[0]))

    def handle_endtag(self, tag):
        if tag in self.VOID:
            return
        if not self.stack or self.stack[-1][0] != tag:
            open_tag = self.stack[-1] if self.stack else ("nothing", 0)
            errors.append(f"index.html:{self.getpos()[0]}: </{tag}> closes <{open_tag[0]}> (line {open_tag[1]})")
            # recover: pop to the matching tag if present
            for i in range(len(self.stack) - 1, -1, -1):
                if self.stack[i][0] == tag:
                    del self.stack[i:]
                    break
            return
        self.stack.pop()
        if tag == "script":
            self.in_ld = False

    def handle_data(self, data):
        if self.in_ld:
            self.ld[-1] += data


def read(name):
    p = ROOT / name
    if not p.exists():
        errors.append(f"{name} is missing")
        return ""
    return p.read_text(encoding="utf-8")


html = read("index.html")
if html:
    if not html.lstrip().lower().startswith("<!doctype html>"):
        errors.append("index.html does not start with <!DOCTYPE html>")
    if len(html) < 1000:
        errors.append(f"index.html is suspiciously small ({len(html)} bytes)")
    c = Collector()
    c.feed(html)
    c.close()
    unclosed = [t for t in c.stack if t[0] not in ("html", "body", "head")]
    if unclosed:
        errors.append(f"index.html: unclosed tags: {unclosed[:5]}")
    dup = sorted({i for i in c.ids if c.ids.count(i) > 1})
    if dup:
        errors.append(f"index.html: duplicate ids: {dup}")
    ids = set(c.ids)
    for h in c.hrefs:
        if h.startswith("#") and len(h) > 1 and h[1:] not in ids:
            errors.append(f"index.html: in-page link {h} has no matching id")
    date_modified = set()
    for i, block in enumerate(c.ld, 1):
        try:
            data = json.loads(block)
        except ValueError as e:
            errors.append(f"index.html: JSON-LD block {i} is not valid JSON ({e})")
            continue
        for m in re.finditer(r'"dateModified":\s*"([^"]+)"', json.dumps(data)):
            date_modified.add(m.group(1))
    for m in re.finditer(r"<!--\s*LINK CHECK:[^>]*-->", html):
        line = html.count("\n", 0, m.start()) + 1
        warnings.append(f"index.html:{line}: unresolved {m.group(0)}")

def news_date(text, where):
    """The date of a news item written as `Nov 4, 2026`, or None (with an error)."""
    try:
        day = datetime.datetime.strptime(text, "%b %d, %Y").date()
    except ValueError:
        day = None
    if day is None or text != f"{day:%b} {day.day}, {day.year}":
        errors.append(f"{where}: date {text!r} is not in the form 'Nov 4, 2026'")
        return None
    return day


def check_news_order(items, where):
    dates = [d for _, d in items if d]
    if dates != sorted(dates, reverse=True):
        errors.append(f"{where}: news items are not ordered newest first")
    if dates and (datetime.date.today() - dates[-1]).days > 93:
        warnings.append(f"{where}: news items older than 3 months (oldest {dates[-1]})")


# News: every item has its own date, `Nov 4, 2026`, the same in SPEC.md and index.html, newest first.
spec = read("SPEC.md")
spec_news = {}
if spec and "## News" in spec:
    block = spec[spec.index("## News"):]
    block = block[:block.index("\n---")] if "\n---" in block else block
    items = []
    for line in block.splitlines():
        if line.startswith("- http"):
            errors.append(f"SPEC.md News: item has no date: {line[:90]}")
        m = re.match(r"- ([A-Z][a-z]{2} \d{1,2}, \d{4}): (https?://\S+)$", line)
        if m:
            day = news_date(m.group(1), "SPEC.md News")
            items.append((m.group(2), day))
            spec_news[m.group(2)] = m.group(1)
    check_news_order(items, "SPEC.md News")
if html and '<section id="news">' in html:
    section = html[html.index('<section id="news">'):]
    section = section[:section.index("</section>")]
    items = []
    for li in re.findall(r"<li>.*?</li>", section, re.S):
        m = re.match(r'<li><time datetime="(\d{4}-\d{2}-\d{2})">([^<]+)</time> <a href="([^"]+)"', li)
        if not m:
            errors.append(f"index.html news: item without a leading <time datetime=...>: {li[:90]}")
            continue
        day = news_date(m.group(2), "index.html news")
        if day and day.isoformat() != m.group(1):
            errors.append(f"index.html news: datetime {m.group(1)} != {m.group(2)}")
        if spec_news and spec_news.get(m.group(3)) != m.group(2):
            errors.append(f"index.html news: {m.group(3)} is dated {m.group(2)}, SPEC.md says {spec_news.get(m.group(3))}")
        items.append((m.group(3), day))
    check_news_order(items, "index.html news")

sitemap = read("sitemap.xml")
if sitemap:
    try:
        ns = {"s": "http://www.sitemaps.org/schemas/sitemap/0.9"}
        lastmods = {e.text for e in ET.fromstring(sitemap).findall(".//s:lastmod", ns)}
        if html and date_modified and lastmods and lastmods != date_modified:
            errors.append(f"sitemap.xml lastmod {sorted(lastmods)} != JSON-LD dateModified {sorted(date_modified)}")
    except ET.ParseError as e:
        errors.append(f"sitemap.xml is not valid XML ({e})")

for name in ("llms.txt", "llms-full.txt"):
    text = read(name)
    if text and not text.startswith("# AI4JVM"):
        errors.append(f"{name} should start with '# AI4JVM'")

robots = read("robots.txt")
if robots and "sitemap:" not in robots.lower():
    warnings.append("robots.txt has no Sitemap: line")

for w in warnings:
    print(f"warning: {w}")
for e in errors:
    print(f"error: {e}")
print(f"{len(errors)} error(s), {len(warnings)} warning(s)")
sys.exit(1 if errors else 0)
