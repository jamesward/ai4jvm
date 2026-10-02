# AI4JVM

Single-page website (`index.html`) — HTML + inline CSS, no build step. Published at https://ai4jvm.com.

Follow the `zen-of-projects` Skill (https://start.jamesward.com, "Website Projects"); this file records
only site-specific facts. The maintenance routine is `.factory/MAINTENANCE.md`.

## Spec

`SPEC.md` is the source of truth for all site content and structure. When updating the site:

1. Update `SPEC.md` first with the new content, links, and descriptions
2. Then regenerate the published files from it:
   - `index.html`: the page itself
   - `llms.txt`: short index of the sections
   - `llms-full.txt`: every section and entry as Markdown
   - `sitemap.xml`: `lastmod` equals the JSON-LD `dateModified` in `index.html`; bump both when
     content changes
3. Run `python3 .factory/check-site.py`. CI runs it too.

## Style Rules

- Keep descriptions concise (2-3 sentences) and factual
- Cards use badge classes: `badge-framework`, `badge-inference`, `badge-assistant`, `badge-resource`
- Each card has a title, description, and links (Docs, GitHub, Website, etc.)
- If a project is abandoned but still useful, note it in the description (e.g. "⚠️ No longer actively maintained"). Remove abandoned projects that are no longer useful.

## Fetching

- When needed use a browser tool to fetch web pages
- **Never infer or guess page contents from URLs.** Always fetch the actual page content (via web search, browser tool, or other means) before writing titles, descriptions, or summaries. If a direct fetch fails, use web search to find the content.

## Publishing

- Every push to `main` is deployed: an AWS CodeBuild project (defined in `jamesward/domains` through
  `cfn-pkl-extras`' `staticSite`) syncs the repo to S3 and invalidates CloudFront.
- `.slugignore` lists files that are not published (one glob per line). Add any new non-site file to it.
- Contributions arrive as PRs, often from forks. The maintenance routine reviews them against
  `CONTRIBUTING.md`, regenerates the site, and merges or escalates (see `.factory/MAINTENANCE.md`).
  There are no slash-command workflows any more. Maintainer comments such as `/review`, `/regen` or
  `/update` are handled on the next routine run.

## Exceptions to zen-of-projects

- No build tool, SkillsJars or MCP servers. The routine loads the Skill from https://start.jamesward.com.
- CI only runs the structural checks in `.factory/check-site.py`. Content quality is judged by the
  routine.
