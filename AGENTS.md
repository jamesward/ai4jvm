# AI4JVM

Single-page website (`index.html`) — HTML + inline CSS, no build step. Published at https://ai4jvm.com.

Follow the `zen-of-websites` and `zen-of-projects` Skills (in https://github.com/jamesward/skills); this file records
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

## Release sources

The projects whose releases the News section and the frameworks list track (`.factory/MAINTENANCE.md`
step 4 checks every row). The Project column is the `SPEC.md` heading; releases are at
`https://github.com/<repo>/releases`. When you start tracking a project, add a row. When coordinates stop
resolving, find the new ones in the project's README or release notes and fix the row.

| Project | Maven coordinates | GitHub repo | Notes |
|---|---|---|---|
| Spring AI | `org.springframework.ai:spring-ai-model` | `spring-projects/spring-ai` | |
| LangChain4j | `dev.langchain4j:langchain4j` | `langchain4j/langchain4j` | |
| Embabel | `com.embabel.agent:embabel-agent-api` | `embabel/embabel-agent` | |
| Google ADK for Java | `com.google.adk:google-adk` | `google/adk-java` | |
| Google ADK for Kotlin | `com.google.adk:google-adk-kotlin-core` | `google/adk-kotlin` | |
| Quarkus LangChain4j | `io.quarkiverse.langchain4j:quarkus-langchain4j-core` | `quarkiverse/quarkus-langchain4j` | 1.x stable and 2.0 pre-releases are published side by side |
| Quarkus Flow | `io.quarkiverse.flow:quarkus-flow` | `quarkiverse/quarkus-flow` | |
| Micronaut LangChain4j | `io.micronaut.langchain4j:micronaut-langchain4j-core` | `micronaut-projects/micronaut-langchain4j` | |
| Helidon LangChain4j | `io.helidon.integrations.langchain4j:helidon-integrations-langchain4j` | `helidon-io/helidon` | Versioned with Helidon 4.x; the repo also tags other Helidon lines |
| MCP Java SDK | `io.modelcontextprotocol.sdk:mcp` | `modelcontextprotocol/java-sdk` | |
| A2A Java SDK | `org.a2aproject.sdk:a2a-java-sdk-client` | `a2aproject/a2a-java` | Not `io.github.a2asdk`, which stopped at 1.0.0.Alpha3 |
| Koog (JetBrains) | `ai.koog:koog-agents-jvm` | `JetBrains/koog` | |
| AgentScope Java | `io.agentscope:agentscope-core` | `agentscope-ai/agentscope-java` | |
| LangGraph4j | `org.bsc.langgraph4j:langgraph4j-core` | `langgraph4j/langgraph4j` | Maintains 1.8.x and 1.9.x; GitHub's "Latest" can be the older line |
| Spring AI Alibaba | `com.alibaba.cloud.ai:spring-ai-alibaba-agent-framework` | `alibaba/spring-ai-alibaba` | |
| Semantic Kernel (Java) | `com.microsoft.semantic-kernel:semantickernel-api` | `microsoft/semantic-kernel-java` | GitHub releases lag Maven Central; tags are `java-<version>` |
| Akka Agents | none on Maven Central | `akka/akka-sdk` | `io.akka:akka-javasdk` is only on `repo.akka.io`, which needs a token; use GitHub releases |
| Anthropic Java SDK | `com.anthropic:anthropic-java` | `anthropics/anthropic-sdk-java` | |
| OpenAI Java SDK | `com.openai:openai-java` | `openai/openai-java` | |
| Google Gen AI Java SDK | `com.google.genai:google-genai` | `googleapis/java-genai` | |
| TornadoVM | `io.github.beehive-lab:tornado-api` | `beehive-lab/TornadoVM` | Versions carry a JDK suffix (`8.1.0-jdk22plus` is tag `v8.1.0`) |
| Deep Java Library (DJL) | `ai.djl:api` | `deepjavalibrary/djl` | GitHub releases can lag Maven Central |

## Publishing

- Every push to `main` is deployed: an AWS CodeBuild project (defined in `jamesward/domains` through
  `cfn-pkl-extras`' `staticSite`) syncs the repo to S3 and invalidates CloudFront.
- `.slugignore` lists files that are not published (one glob per line). Add any new non-site file to it.
- Contributions arrive as PRs, often from forks. The maintenance routine reviews them against
  `CONTRIBUTING.md`, regenerates the site, and merges or escalates (see `.factory/MAINTENANCE.md`).
  There are no slash-command workflows any more. Maintainer comments such as `/review`, `/regen` or
  `/update` are handled on the next routine run.

## Exceptions to zen-of-projects

- No build tool, SkillsJars or MCP servers. The routine loads the Skill from a clone of `jamesward/skills`
  (see `.factory/MAINTENANCE.md` step 1).
- CI only runs the structural checks in `.factory/check-site.py`. Content quality is judged by the
  routine.
