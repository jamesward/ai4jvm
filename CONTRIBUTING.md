# Contributing

## Guidelines

The site aims to capture the most relevant AI resources for Java developers.
General AI resources are not included - only those that are specific to Java developers.
We aim to include resources that are relevent to > 10% of Java developers using or building on AI.
The people who are included should be helping those developers learn how to use and build on AI with public projects, presentations, code examples, libraries, tools, etc.

**Project activity matters.** Check that projects and resources are actively maintained (recent commits, releases, or updates). If a project is abandoned but still useful (stable, working, no viable replacement), it can be included with a clear note indicating it is no longer actively maintained. If a project is abandoned and no longer useful (outdated, superseded, or broken), it should not be included.

## Process

1. Make changes to `SPEC.md` (the source of truth for the site content)
2. Optionally, have your AI code assistant regenerate `index.html`, `llms.txt`, `llms-full.txt` and `sitemap.xml` from it, and run `python3 .factory/check-site.py`
3. Send a PR

A daily maintenance routine reviews open PRs against these guidelines, verifies every link, regenerates the site if needed, and then merges the PR or asks the maintainer for a decision.
