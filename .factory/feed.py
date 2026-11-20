#!/usr/bin/env python3
"""Generates feed.xml (RSS 2.0) from the News section of index.html.

    python3 .factory/feed.py

The feed is derived, never edited by hand: check-site.py fails when feed.xml differs from what this
script would write, so run it whenever the News list changes.
"""
import datetime
import html as htmllib
import re
from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path(__file__).resolve().parent.parent
SITE = "https://ai4jvm.com/"
FEED_URL = SITE + "feed.xml"
ITEM = re.compile(
    r'<li><time datetime="(\d{4}-\d{2}-\d{2})">[^<]+</time> <a href="([^"]+)">(.*?)</a> &mdash; (.*?)</li>', re.S
)


def text(fragment):
    """Plain text of an HTML fragment: tags dropped, entities decoded."""
    return " ".join(htmllib.unescape(re.sub(r"<[^>]+>", "", fragment)).split())


def rfc822(day):
    return datetime.datetime(day.year, day.month, day.day, tzinfo=datetime.timezone.utc).strftime(
        "%a, %d %b %Y %H:%M:%S +0000"
    )


def news_items(page):
    """(date, link, title, description HTML) for every News item, in page order."""
    if '<section id="news">' not in page:
        return []
    section = page[page.index('<section id="news">'):]
    section = section[:section.index("</section>")]
    return [
        (datetime.date.fromisoformat(d), htmllib.unescape(link), text(title), desc.strip())
        for d, link, title, desc in ITEM.findall(section)
    ]


def build(page):
    items = news_items(page)
    title = text(re.search(r"<title>(.*?)</title>", page, re.S).group(1))
    description = htmllib.unescape(re.search(r'<meta name="description" content="([^"]*)"', page).group(1))
    out = [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">',
        "  <channel>",
        f"    <title>{escape(title)}</title>",
        f"    <link>{SITE}</link>",
        f"    <description>{escape(description)}</description>",
        "    <language>en-us</language>",
        f'    <atom:link href="{FEED_URL}" rel="self" type="application/rss+xml"/>',
    ]
    if items:
        out.append(f"    <lastBuildDate>{rfc822(max(i[0] for i in items))}</lastBuildDate>")
    for day, link, item_title, desc in items:
        out += [
            "    <item>",
            f"      <title>{escape(item_title)}</title>",
            f"      <link>{escape(link)}</link>",
            f'      <guid isPermaLink="true">{escape(link)}</guid>',
            f"      <pubDate>{rfc822(day)}</pubDate>",
            f"      <description>{escape(desc)}</description>",
            "    </item>",
        ]
    out += ["  </channel>", "</rss>", ""]
    return "\n".join(out)


if __name__ == "__main__":
    (ROOT / "feed.xml").write_text(build((ROOT / "index.html").read_text(encoding="utf-8")), encoding="utf-8")
    print("wrote feed.xml")
