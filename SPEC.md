# AI4JVM Site Specification

AI4JVM is a curated guide to the Java AI ecosystem — a single-page website covering agent frameworks, inference engines, code assistants, key people, and learning resources.

## Guidelines

- Validate accuracy with recent web information
- **Project activity:** When researching or reviewing projects, check how active they are (recent commits, releases, maintainer responsiveness). If a project is abandoned but still useful (e.g. stable library with no need for updates), keep it but add a note like `⚠️ No longer actively maintained` in its description. If a project is abandoned and no longer useful (e.g. outdated, superseded, or broken), remove it from the site.

## SEO

### Head & Meta
- **Title tag:** "AI4JVM — Java & JVM AI Ecosystem Guide: Agent Frameworks, Inference Engines & Tools"
- **Meta description:** "The curated guide to AI on the JVM — Spring AI, LangChain4j, Kotlin AI frameworks, inference engines, and more. Compare Java AI agent frameworks, find learning resources, and follow key people building the Java AI ecosystem."
- **Canonical URL:** `https://ai4jvm.com/`
- Keep Open Graph and Twitter Card meta tags in sync with the title/description above

### Structured Data (JSON-LD)
- Include `WebSite` schema (existing)
- Add an `ItemList` schema enumerating the major frameworks/tools as `ListItem` entries with name, url, and position. This helps Google display the site as a rich result for "Java AI frameworks" queries.
- Add a `FAQPage` schema for the FAQ section (see below)

### Heading Hierarchy
- `<h1>`: One per page (the hero title) — must contain primary keywords "Java" and "AI"
- `<h2>`: One per major section (News, Agent Frameworks & Libraries, Java with Code Assistants, Inference & Training, People to Follow, FAQ, Resources)
- `<h3>`: Individual cards/items within sections
- `<h4>`: Sub-items (e.g. person names in People section)
- The News section must use `<h2>` (not `<h3>`) for its heading

### Section Introductions
Each major content section (`<section>`) should have a 1–2 sentence introduction paragraph below its `<h2>` heading. These intro paragraphs provide keyword-rich body text for search engines and context for users. Examples:
- **Agent Frameworks & Libraries:** "Open-source frameworks and SDKs for building AI-powered applications on the JVM — from full agent platforms to Model Context Protocol implementations."
- **Java with Code Assistants:** "Tools that bridge AI coding assistants and the Java ecosystem — MCP servers, skill registries, and IDE integrations."
- **Inference & Training:** "Run LLM inference, train ML models, and deploy AI workloads directly on the JVM without Python dependencies."
- **People to Follow:** "Key voices and project leads shaping the Java AI ecosystem."
- **Resources:** "Talks, tutorials, books, and communities for learning AI development on the JVM."

### FAQ Section
Add a FAQ section before the Resources section. This targets long-tail search queries. Use `<h2>FAQ</h2>` heading and render as an accordion or simple Q&A list. Each Q&A pair should also be included in FAQPage structured data.

Questions and answers:
- **"What is the best Java framework for building AI agents?"** — "The most popular choices are Spring AI and LangChain4j. Spring AI is ideal if you're already in the Spring ecosystem, offering portable abstractions across 20+ model providers. LangChain4j provides a standalone library with three levels of abstraction, from low-level prompts to high-level AI Services. Other options include Google ADK for Java, Embabel, and Akka Agents — each with different strengths for specific use cases."
- **"Can Java run LLMs locally?"** — "Yes. Projects like Jlama and GPULlama3.java run Llama, Mistral, and other models directly on the JVM. Jlama uses Java's Vector API for SIMD-accelerated inference on CPU, while GPULlama3.java leverages TornadoVM for GPU acceleration. For production deployments, ONNX Runtime Java supports hardware-accelerated inference across CUDA, DirectML, and CoreML."
- **"What is MCP and how does it work with Java?"** — "The Model Context Protocol (MCP) is an open standard that lets AI assistants interact with external tools and data sources. The official MCP Java SDK, maintained by the Spring AI team, provides both client and server implementations with sync/async support and multiple transports (STDIO, Streamable HTTP; SSE deprecated as of 2.0). Helidon MCP and several frameworks also offer MCP support."
- **"Is Kotlin supported by Java AI frameworks?"** — "Yes. Most Java AI frameworks run on any JVM language. Embabel is written in Kotlin with full Java interop, Koog from JetBrains is a Kotlin-native agent framework, and Tracy provides AI observability for Kotlin. LangChain4j and Spring AI work seamlessly from Kotlin code."

### Sitemap
- `sitemap.xml` must have `<lastmod>` updated whenever `index.html` content changes
- Keep `<changefreq>weekly</changefreq>` and `<priority>1.0</priority>`

### Robots.txt
- Keep `Allow: /` and `Sitemap:` directive (already correct)

## Site Structure

- Single `index.html` file (HTML + inline CSS, no build step)
- Dark theme with card-based layout
- Sticky nav, hero section, then content sections separated by dividers
- Responsive: cards collapse to single column on mobile
- Preserve the ordering in this spec

## Visual Design

- Dark background (`#0f1117`), card surfaces (`#1e2230`), accent purple (`#6c63ff`), accent blue (`#38bdf8`), accent pink (`#f472b6`)
- Cards have hover effects (border highlight, slight lift)
- Badge types: `badge-framework` (purple), `badge-inference` (blue), `badge-assistant` (pink), `badge-resource` (green)
- Where possible use icons for links - for blog or other use a world / www icon. don't use text labels.
- In a given section, use different colors for different badge types.

### Link Affordance
- **Clickable cards:** If a card has a single primary destination (e.g. resource cards with one link), make the entire card an `<a>` tag so clicking anywhere on the card navigates. Keep secondary icon links overlaid on top.
- **Card titles as links:** For cards with multiple links (frameworks, tools), make the card `h3` title a clickable link to the primary resource (docs or website). Style title links with an underline on hover.
- **News links:** Underline news item links so they're visually distinct from surrounding text.
- **Inline text links:** Any link within body text or descriptions should be underlined.
- **Don't mislead:** Only apply hover lift/border effects to cards that are actually clickable. Non-clickable cards should still have a subtle hover border but no translateY lift.

## Hero

- Title: "Java meets **Artificial Intelligence**" (gradient text on "Artificial Intelligence")
- Subtitle: "The curated guide to AI on the JVM — compare agent frameworks, inference engines, code assistants, and find the people and resources shaping the Java AI ecosystem."

---

## News

Latest headlines about the Java AI ecosystem. Each item has a link and brief description.
Note: Order by date, newest first. Don't show news older than 3 months

- https://foojay.io/today/introduction-to-retrieval-augmented-generation-with-java-and-mongodb/
- https://github.com/a2aproject/a2a-java/releases/tag/v1.2.0.Final
- https://camel.apache.org/blog/2026/08/camel-ai-tools-mcp-422/
- https://github.com/agentscope-ai/agentscope-java/releases/tag/v2.0.1
- https://www.infoq.com/news/2026/08/java-news-roundup-jul27-2026/
- https://github.com/jakartaee/agentic-ai/releases/tag/1.0.0-M1
- https://foojay.io/today/how-to-create-a-spring-boot-fraud-scoring-service/
- https://javapro.io/2026/07/29/connecting-java-reinforcement-learning-to-python-gymnasium/
- https://micronaut.io/2026/07/27/micronaut-framework-5-1-0-release/
- https://medium.com/graalvm/when-prompts-become-plugins-34a737d30f54
- https://inside.java/2026/07/25/design-java-mcp-tool/
- https://github.com/embabel/embabel-agent/releases/tag/v1.0.0
- https://github.com/beehive-lab/TornadoVM/releases/tag/v5.2.0-jdk21
- https://inside.java/2026/07/23/podcast-063/
- https://foojay.io/today/ai-found-the-bugs-whos-patching-your-eol-java-code/
- https://github.com/JetBrains/koog/releases/tag/1.1.1
- https://javapro.io/2026/07/16/solving-spring-ais-ui-challenge-with-ag-uis-java-sdk/
- https://github.com/langchain4j/langchain4j/releases/tag/1.18.0
- https://foojay.io/today/i-asked-github-copilot-to-profile-a-java-app-it-found-a-bug-in-my-heap-sizing-and-offered-to-fix-it/
- https://quarkus.io/blog/quarkus-langchain4j-opa-guardrails/
- https://github.com/spring-ai-community/spring-ai-agentcore/releases/tag/v2.0.0
- https://github.com/agentscope-ai/agentscope-java/releases/tag/v2.0.0
- https://javapro.io/2026/07/08/langchain4j-agentic-workflows-from-ai-calls-to-multi-agent-systems-in-java/
- https://foojay.io/today/building-ai-systems-with-mongodb-implementing-the-planning-pattern/
- https://a2aproject.github.io/a2a-java/posts/a2a-java-sdk-1-1-0-final-released/
- https://quarkus.io/blog/a2a-java-sdk-1-0-0-final-released/
- https://spring.io/blog/2026/06/12/spring-ai-2-0-0-GA-available-now
- https://github.com/modelcontextprotocol/java-sdk/releases/tag/v2.0.0
- https://java.agentscope.io/v2/en/blogs/agentscope-v2-release.html
- https://javapro.io/2026/06/03/the-gen-ai-iceberg-java-tooling-edition/
- https://blog.jetbrains.com/ai/2026/05/koog-1-0-is-out-stable-core-better-interop-and-multiplatform-observability/
- https://quarkus.io/blog/introducing-voting-pattern/
- https://micronaut.io/2026/05/20/micronaut-framework-5-0-0-released/
- https://blog.ovhcloud.com/devoxx-france-2026/

---

## Agent Frameworks & Libraries

### Spring AI
- **Badge:** Framework
- **Description:** The Spring ecosystem's official AI framework. Portable abstractions across 20+ model providers, tool calling, RAG, chat memory, vector stores, and MCP support. Built by the Spring team at Broadcom.
- **Links:** [Docs](https://spring.io/projects/spring-ai/) · [GitHub](https://github.com/spring-projects/spring-ai) · [Overview](https://spring.io/ai/)

### LangChain4j
- **Badge:** Framework
- **Description:** The most popular Java LLM library. Unified API across 20+ LLM providers and 20+ embedding stores. Three levels of abstraction from low-level prompts to high-level AI Services. Supports RAG, tool calling, MCP, and agents.
- **Links:** [Docs](https://docs.langchain4j.dev/) · [GitHub](https://github.com/langchain4j/langchain4j)

### Embabel
- **Badge:** Framework
- **Description:** Created by Rod Johnson (Spring Framework creator). JVM agent framework using Goal-Oriented Action Planning (GOAP) for dynamic replanning. Strongly typed, Spring-integrated, MCP support. Written in Kotlin with full Java interop.
- **Links:** [GitHub](https://github.com/embabel/embabel-agent) · [Blog](https://medium.com/@springrod/embabel-a-new-agent-platform-for-the-jvm-1c83402e0014)

### Google ADK for Java
- **Badge:** Framework
- **Description:** Google's Agent Development Kit — code-first Java toolkit for building, evaluating, and deploying AI agents. Supports Gemini natively plus third-party models via LangChain4j integration. A2A protocol for agent-to-agent communication.
- **Links:** [Docs](https://google.github.io/adk-docs/get-started/java/) · [GitHub](https://github.com/google/adk-java) · [Codelab](https://codelabs.developers.google.com/adk-java-getting-started)

### Quarkus LangChain4j
- **Badge:** Framework
- **Description:** Enterprise-grade Quarkus extension for LangChain4j. Native compilation with GraalVM, built-in observability (metrics, tracing, auditing), and Dev UI tooling. Maintained by Red Hat & IBM.
- **Links:** [Docs](https://docs.quarkiverse.io/quarkus-langchain4j/dev/index.html) · [GitHub](https://github.com/quarkiverse/quarkus-langchain4j)

### Helidon LangChain4j
- **Badge:** Framework
- **Description:** Oracle's Helidon framework integration with LangChain4j. Declarative AI Services via Helidon Inject, build-time code generation for GraalVM native images, streaming chat over Java Streams, guardrails, built-in metrics, and agentic support (workflows and dynamic agents). Runs on virtual threads.
- **Links:** [Docs](https://helidon.io/docs/v4/se/ai/langchain4j/langchain4j) · [GitHub](https://github.com/helidon-io/helidon-examples/tree/helidon-4.x/examples/integrations/langchain4j)

### Helidon MCP
- **Badge:** Framework
- **Description:** Helidon's Model Context Protocol server and client implementation. Declarative and imperative APIs for building MCP servers with tools, resources, and prompts. Streamable HTTP and SSE transports, virtual threads, build-time processing. From Oracle's Helidon team.
- **Links:** [Docs](https://helidon.io/docs/v4/se/ai/mcp) · [GitHub](https://github.com/helidon-io/helidon-mcp)

### Micronaut MCP
- **Badge:** Framework
- **Description:** Official Micronaut module for building Model Context Protocol servers and clients. STDIO and Streamable HTTP transports, annotation and factory-based tools/prompts/resources, a LangChain4j-backed client option, and GraalVM native image support. Maintained by the Micronaut project team.
- **Links:** [Docs](https://micronaut-projects.github.io/micronaut-mcp/latest/guide/) · [GitHub](https://github.com/micronaut-projects/micronaut-mcp)

### LangChain4j-CDI
- **Badge:** Framework
- **Description:** CDI extension for LangChain4j (part of the LangChain4j project) that brings AI services to Jakarta EE and MicroProfile applications. Inject AI services as CDI beans with `@RegisterAIService`, configure via MicroProfile Config, and add resilience with Fault Tolerance. Supports Quarkus, Helidon, WildFly, Payara, GlassFish, Liberty, and any CDI-capable runtime.
- **Links:** [GitHub](https://github.com/langchain4j/langchain4j-cdi)

### LangGraph4j
- **Badge:** Framework
- **Description:** Build stateful, multi-agent applications with cyclical graphs. Inspired by Python's LangGraph, works with both LangChain4j and Spring AI. Persistent checkpoints, deep agent architectures, and a Studio web UI.
- **Links:** [Docs](https://langgraph4j.github.io/langgraph4j/) · [GitHub](https://github.com/langgraph4j/langgraph4j)

### Akka Agents
- **Badge:** Framework
- **Description:** Agentic AI platform built on Akka's actor model for distributed, resilient systems. Declarative Effects API for building goal-directed agents with durable memory, multi-agent orchestration, and automatic scaling. Task-based autonomous agents with pause/resume/terminate lifecycle control and task result subscriptions, alongside request-based agents. MCP and A2A protocol support, pluggable LLM providers, runtime prompt updates, and agents auto-exposed as HTTP, gRPC, or MCP endpoints. Java and Scala SDKs.
- **Links:** [Docs](https://doc.akka.io/) · [GitHub](https://github.com/akka/akka-sdk) · [Website](https://akka.io/akka-agents)

### Koog (JetBrains)
- **Badge:** Framework
- **Description:** Kotlin-native agent framework from JetBrains. Type-safe DSL, multiplatform (JVM, JS, WasmJS, Android, iOS), A2A protocol support, fault tolerance with persistence, and multi-LLM support.
- **Links:** [Website](https://www.jetbrains.com/koog/) · [GitHub](https://github.com/JetBrains/koog) · [Docs](https://docs.koog.ai/)

### Semantic Kernel (Java)
- **Badge:** Framework
- **Description:** Microsoft's AI orchestration SDK with first-class Java support. Provides prompt chaining, planning, memory, and agent framework abstractions with deep Azure integration.
- **Links:** [GitHub](https://github.com/microsoft/semantic-kernel-java)

### JamJet
- **Badge:** Framework
- **Description:** Production-grade agent runtime with native Java SDK. Rust core (Tokio) for performance, graph-based durable workflow orchestration with event-sourced state, automatic crash recovery, audit trails, and first-class human-in-the-loop. Native MCP client/server and A2A protocol support. Java SDK uses records, virtual threads, and fluent builder API. Apache 2.0.
- **Links:** [Docs](https://docs.jamjet.dev) · [GitHub](https://github.com/jamjet-labs/jamjet) · [Examples](https://github.com/jamjet-labs/jamjet/tree/main/sdk/java/examples)

### Spring AI AgentCore SDK
- **Badge:** SDK
- **Description:** Spring Boot integrations for Amazon Bedrock AgentCore. Auto-configures `/invocations` and `/ping` endpoints, SSE streaming, short- and long-term memory, browser automation via Playwright, and a secure code interpreter. Deploy to AgentCore Runtime (managed, scales to zero) or standalone on EKS/ECS.
- **Links:** [Docs](https://springaicommunity.mintlify.app/projects/incubating/spring-ai-bedrock-agentcore) · [GitHub](https://github.com/spring-ai-community/spring-ai-agentcore)

### MCP Java SDK
- **Badge:** SDK
- **Description:** The official Java SDK for Model Context Protocol servers and clients. Maintained by the Spring AI team. Sync/async, STDIO/Streamable HTTP transports (SSE deprecated as of 2.0), OAuth support via Spring integration. Reached v2.0.0 GA in June 2026 with spec-accurate JSON Schema 2020-12 validation and enforced required fields.
- **Links:** [Docs](https://modelcontextprotocol.io/sdk/java/mcp-overview) · [GitHub](https://github.com/modelcontextprotocol/java-sdk)

### Anthropic Java SDK
- **Badge:** SDK
- **Description:** Official Java SDK for the Claude Messages API. Streaming, retries, structured outputs, extended thinking, code execution, and files API. Build Java apps powered by Claude.
- **Links:** [GitHub](https://github.com/anthropics/anthropic-sdk-java)

### GitHub Copilot SDK for Java
- **Badge:** SDK
- **Description:** Official Java SDK for embedding the GitHub Copilot agentic engine directly into Java applications. Uses the same agentic harness that powers the Copilot CLI — exposes planning, tool calling, file editing, and MCP integration via a simple Java API. Currently in technical preview.
- **Links:** [Docs](https://github.github.com/copilot-sdk-java/) · [GitHub](https://github.com/github/copilot-sdk-java)

### Graal Script Agent
- **Badge:** Library
- **Description:** Early-preview Java library for adding prompt-authored extensions to Java applications. Developers define where an application can be extended; users prompt for the behavior they need. It produces reusable JavaScript or Python extensions that execute locally in a sandbox without another model call.
- **Links:** [Docs](https://graalvm.github.io/graal-script-agent/latest/) · [GitHub](https://github.com/graalvm/graal-script-agent) · [Blog](https://medium.com/graalvm/when-prompts-become-plugins-34a737d30f54)

### Tracy (JetBrains)
- **Badge:** Library
- **Description:** AI tracing library for Kotlin and Java. Captures structured traces from LLM interactions — messages, cost, token usage, and execution time. Implements OpenTelemetry Generative AI Semantic Conventions with exports to Langfuse, Weights & Biases, and more.
- **Links:** [Docs](https://jetbrains.github.io/tracy/latest) · [GitHub](https://github.com/JetBrains/tracy)

### Docling Java
- **Badge:** Library
- **Description:** Official Java client for Docling Serve — invoke document conversion, table detection, formula recognition, reading order analysis, OCR, and more from Java via the Docling Serve backend.
- **Links:** [Docs](https://docling-project.github.io/docling-java/current) · [GitHub](https://github.com/docling-project/docling-java)

### OmniHai
- **Badge:** Library
- **Description:** Unified Java AI utility library for Jakarta EE and MicroProfile. Single API across 10 providers with zero external runtime dependencies — just java.net.http.HttpClient. Chat, streaming, structured outputs, web search, translation, and moderation in a lightweight JAR.
- **Links:** [Website](https://omnihai.org) · [GitHub](https://github.com/omnifaces/omnihai) · [Javadoc](https://javadoc.io/doc/org.omnifaces/omnihai)

### ACP Langchain4j bridge
- **Badge:** Library
- **Description:** An ACP client bridging the official [Kotlin ACP sdk](https://agentclientprotocol.com/libraries/kotlin) to [LangChain4j](https://docs.langchain4j.dev/intro/) and [LangGraph4j](https://github.com/langgraph4j/langgraph4j).
- **Links:** [GitHub](https://github.com/OsgiliathEnterprise/acp-langgraph-langchain-bridge)

### A2A Java SDK
- **Badge:** SDK
- **Description:** The official Java SDK for [Agent-2-Agent Protocol (A2A)](https://a2a-protocol.org) servers and clients. Reference implementation based on Quarkus. Reached 1.0 GA in June 2026 with full JSON-RPC/gRPC/REST transport support, OpenTelemetry integration, and a cross-SDK interop test kit; 1.1.0 added a `TaskAuthorizationProvider` SPI for per-user task authorization; 1.2.0 (Aug 2026) adds programmatic auth wiring and a `TaskStreamLifecycleHook`, with breaking changes to `TaskState` naming and cross-module package resolution.
- **Links:** [GitHub](https://github.com/a2aproject/a2a-java)

### A2A Java SDK for Jakarta Servers
- **Badge:** SDK
- **Description:** Integration of the [A2A Java SDK](https://github.com/a2aproject/a2a-java) for use in Jakarta EE servers (WildFly, Tomcat, Jetty, OpenLiberty, and others).
- **Links:** [GitHub](https://github.com/wildfly-extras/a2a-java-sdk-server-jakarta)

### WildFly AI Feature Pack
- **Badge:** Framework
- **Description:** A feature pack for WildFly, providing seamless LangChain4j-CDI integration and exposing Jakarta EE code as MCP tools via MCP_JAVA Annotations.
- **Links:** [GitHub](https://github.com/wildfly-extras/wildfly-ai-feature-pack)

### MCP_JAVA Annotations
- **Badge:** Library
- **Description:** A framework-agnostic Java library providing core annotations and APIs for implementing Model Context Protocol (MCP) servers and clients. Used by WildFly AI Feature Pack and LangChain4j-CDI. Compatible with OpenLiberty, Quarkus, and other Java frameworks.
- **Links:** [GitHub](https://github.com/mcp-java/java-mcp-annotations)

### Atmosphere
- **Badge:** Framework
- **Description:** A portable layer across Java AI runtimes. Write `@Agent` once against a unified API (tool calling, memory, streaming, structured output); swap the runtime — Spring AI, LangChain4j, Google ADK, Embabel, Koog, or built-in OpenAI — by changing one dependency. `@Coordinator` orchestrates multi-agent fleets with parallel, sequential, and conditional routing. Served over transports (WebTransport/HTTP3, WebSocket, SSE, long-polling, gRPC) and protocols (MCP, A2A, AG-UI). Built by Async-IO.
- **Links:** [Docs](https://atmosphere.github.io/docs/) · [GitHub](https://github.com/Atmosphere/atmosphere) · [Async-IO](https://async-io.live)

### Spring AI Agent Utils
- **Badge:** Library
- **Description:** Community library from the Spring AI team that brings Claude Code-inspired agentic primitives to Spring AI applications — file operations, shell execution, web fetch, task/subagent orchestration, auto-memory, and a portable Agent Skills implementation. Built on Spring AI 2.0's agentic foundation.
- **Links:** [Docs](https://springaicommunity.mintlify.app/projects/incubating/spring-ai-agent-utils) · [GitHub](https://github.com/spring-ai-community/spring-ai-agent-utils)

### Jakarta Agentic AI
- **Badge:** Framework
- **Description:** Eclipse Foundation specification proposal defining vendor-neutral APIs for building, deploying, and running AI agents on Jakarta EE runtimes. Annotation-based programming model (`@Agent`, `@Trigger`, `@Decision`, `@Action`, `@Outcome`) built on CDI, REST, and Config — pluggable with existing frameworks like LangChain4j and Spring AI rather than replacing them. Proposed by Payara and Reza Rahman, backed by Oracle, Fujitsu, and OmniFish; version 1.0 under active development.
- **Links:** [GitHub](https://github.com/jakartaee/agentic-ai) · [Spec](https://jakarta.ee/specifications/agentic-ai/1.0/) · [Announcement](https://payara.fish/blog/announcing-the-jakarta-agentic-ai-project/)

### AgentScope Java
- **Badge:** Framework
- **Description:** Alibaba's JVM-native framework for production-ready, distributed agents. Event-streaming architecture, permission-gated tool execution, sandboxed tool execution (local, Docker, or Kubernetes), and distributed session/memory backed by Redis, MySQL, or PostgreSQL. Reached v2.0.0 GA in July 2026.
- **Links:** [Website](https://java.agentscope.io/) · [GitHub](https://github.com/agentscope-ai/agentscope-java)

### JVector
- **Badge:** Library
- **Description:** DataStax's pure-Java embedded vector search engine combining DiskANN and HNSW graph designs for approximate nearest-neighbor search, SIMD-accelerated via the Java Vector API. Supports indexes larger than available memory via two-pass compressed search. Powers Apache Cassandra and AstraDB; has an official LangChain4j embedding-store integration.
- **Links:** [GitHub](https://github.com/datastax/jvector) · [LangChain4j Integration](https://docs.langchain4j.dev/integrations/embedding-stores/jvector/)

### Milvus Java SDK
- **Badge:** Library
- **Description:** Official Java client for Milvus, one of the most widely used open-source vector databases. Type-safe API for collection management, ANN and hybrid search, and bulk import, with modular packaging (core plus an optional BulkWriter module). Commonly paired with LangChain4j and Spring AI vector-store integrations in Java RAG stacks.
- **Links:** [GitHub](https://github.com/milvus-io/milvus-sdk-java) · [Website](https://milvus.io)

### ClawRunr
- **Badge:** Framework
- **Description:** Open-source personal AI agent runtime built on Spring Boot, Spring AI, and JobRunr — runs entirely on your own hardware. Schedules and executes background tasks, browses the web, and manages work via human-readable Markdown files, with multi-channel support (chat UI, Telegram, Discord) and pluggable OpenAI, Anthropic, or Ollama providers. Built by the JobRunr team; started as a demo and grew into a community project.
- **Links:** [GitHub](https://github.com/ClawRunr/JavaClaw) · [Website](https://clawrunr.io/)

### MCP Toolbox Java SDK
- **Badge:** SDK
- **Description:** Official Google Java client library for MCP Toolbox. Lets Java agents (Spring Boot, Quarkus, Jakarta EE) discover and invoke Toolbox-defined tools — database queries, API calls — via a type-safe, async-first `CompletableFuture` API with Google Cloud ADC authentication. Apache 2.0; feature set is still catching up to the Python, JS, and Go SDKs.
- **Links:** [Docs](https://mcp-toolbox.dev/documentation/introduction/) · [GitHub](https://github.com/googleapis/mcp-toolbox-sdk-java)

### Tools4AI
- **Badge:** Framework
- **Description:** Pure-Java agentic framework that converts natural-language prompts into executable actions — Java method calls, REST endpoints, shell commands, or Swagger API calls — with multi-provider support across Gemini, OpenAI, Anthropic, and LocalAI. No Spring dependency required. MIT licensed, published to Maven Central.
- **Links:** [GitHub](https://github.com/vishalmysore/Tools4AI) · [Javadoc](https://javadoc.io/doc/io.github.vishalmysore/tools4ai/latest/index.html)

### EclipseStore
- **Badge:** Library
- **Description:** Eclipse Foundation's Java-native persistence engine — stores and loads full object graphs with microsecond response times, no JPA/ORM overhead. Version 4 integrates JVector into its GigaMap indexing, turning EclipseStore into an embedded, pure-Java vector database: HNSW similarity search, on-disk indexing for datasets larger than memory, and Product Quantization to shrink embedding footprints by up to 90%.
- **Links:** [GitHub](https://github.com/eclipse-store/store) · [Docs](https://docs.eclipsestore.io/manual/gigamap/index.html) · [Blog](https://microstream.one/blog/2026/02/13/eclipsestore-4-beta-build-vector-database-apps-with-pure-java/)

### OpenAI Java SDK
- **Badge:** SDK
- **Description:** Official Java client library for the OpenAI API, maintained by OpenAI. Written in Kotlin with full Java interop. Typed access to Chat Completions and the Responses API, streaming, structured outputs, function calling, and asynchronous execution via `CompletableFuture`.
- **Links:** [GitHub](https://github.com/openai/openai-java)

### Google Gen AI Java SDK
- **Badge:** SDK
- **Description:** Google's official Java SDK unifying access to the Gemini Developer API and Vertex AI. Supports Gemini text/chat, Imagen image generation, Veo video generation, embeddings, token counting, and automatic function calling, with streaming and async options. Distinct from Google ADK for Java, which is an agent-orchestration framework built on top of it.
- **Links:** [GitHub](https://github.com/googleapis/java-genai) · [Docs](https://googleapis.github.io/java-genai/javadoc/)

### IBM watsonx.ai Java SDK
- **Badge:** SDK
- **Description:** IBM's official Java SDK for the watsonx.ai enterprise AI platform. Chat completions, streaming, tool calling, embeddings, text classification/extraction/detection, reranking, and time-series forecasting, for both IBM Cloud and on-premises (CP4D) deployments. Integrates with LangChain4j, Quarkus, and Apache Camel.
- **Links:** [GitHub](https://github.com/IBM/watsonx-ai-java-sdk) · [Docs](https://ibm.github.io/watsonx-ai-java-sdk/)

### SAP AI SDK for Java
- **Badge:** SDK
- **Description:** SAP's official Java SDK for integrating generative AI into enterprise applications via SAP AI Core and the Generative AI Hub. Orchestration service integration, prompt templating, grounding, data masking, content filtering, and Spring AI compatibility.
- **Links:** [GitHub](https://github.com/SAP/ai-sdk-java)

### Tiberius
- **Badge:** Library
- **Description:** Java security and safety testing framework for Java LLM-enriched applications, integrating with JUnit 5 and Spring Boot so adversarial testing lives in the standard test suite. 200+ attack probes across the OWASP LLM Top 10, probabilistic testing (via PUnit) for non-deterministic LLM outputs, fixture-based regression testing, bias testing, model fingerprinting, and LangChain4j guardrail validation. Apache 2.0.
- **Links:** [Docs](https://github.com/tiberius-security/tiberius/blob/main/docs/langchain4j-guardrail-testing.md) · [GitHub](https://github.com/tiberius-security/tiberius) · [Blog](https://foojay.io/today/tiberius-a-security-testing-framework-for-llm-applications-in-java/) · [Article](https://dev.karakun.com/2026/07/20/llm-security-testing-java-tiberius.html) · [Podcast](https://foojay.io/today/foojay-podcast-99/)

### Ollama4j
- **Badge:** SDK
- **Description:** Java client library for running models via a local Ollama server. Chat, streaming, tool/function calling (including MCP tools), vision-model image inputs, embeddings, and model management, with Prometheus metrics support. Requires Java 17+, published to Maven Central.
- **Links:** [GitHub](https://github.com/ollama4j/ollama4j)

### Cohere Java SDK
- **Badge:** SDK
- **Description:** Official Java SDK for the Cohere API, generated and maintained by Cohere. Chat, embeddings, reranking, and classification endpoints, published to Maven Central.
- **Links:** [GitHub](https://github.com/cohere-ai/cohere-java)

### kyo-ai
- **Badge:** Framework
- **Description:** AI modules for Kyo, the Scala 3 algebraic-effects toolkit. Makes an LLM call a typed, composable value — `AI.gen[A]` derives the schema from your result type, drives the tool-call loop, and decodes the reply — with durable, crash-resumable agent runs and MCP support. Early stage and under active development. Apache 2.0.
- **Links:** [GitHub](https://github.com/getkyo/kyo-ai) · [Website](https://getkyo.io/)

### zio-bedrock-converse
- **Badge:** SDK
- **Description:** Typed Scala 3 access to the Amazon Bedrock Converse API, built on ZIO and ZIO HTTP. Three abstraction levels — low-level wire control, single-turn requests, and multi-turn agentic loops with automatic tool dispatching — with tool schemas derived from Scala types and streaming text responses. Typed end-to-end with no `DynamicValue` in the public API. Apache 2.0.
- **Links:** [GitHub](https://github.com/jamesward/zio-bedrock-converse)

### zio-http-mcp
- **Badge:** Library
- **Description:** MCP server and client library for Scala 3, ZIO, and ZIO HTTP. Typed tool inputs and outputs via ZIO Schema, resources and prompt templates, OAuth 2.1 authorization, stateful or stateless HTTP transports, and server-initiated messaging (sampling, elicitation) over SSE. Supports the 2025-11-25 and 2026-07-28 MCP protocol revisions with automatic negotiation.
- **Links:** [GitHub](https://github.com/jamesward/zio-http-mcp)

### Tachyon
- **Badge:** Framework
- **Description:** Java 21+ runtime for building high-performance MCP servers — write blocking handler code and virtual threads run it off the Netty event loop, no reactive boilerplate. Stateless by default with optional sessions, native Netty transports (io_uring/epoll/kqueue), a Kotlin DSL, and full MCP 2025-11-25 and 2026-07-28 support verified against the official conformance tests. Apache 2.0, currently in beta.
- **Links:** [GitHub](https://github.com/kpavlov/tachyon)

### Solon-AI
- **Badge:** Framework
- **Description:** Full-scenario Java AI application module of the Solon framework ecosystem — LLM chat and tool/skill calling, RAG knowledge bases, MCP client/server support, and ReAct/multi-agent Team orchestration. Embeddable in Spring Boot, jFinal, Vert.x, and Quarkus; supports Java 8–25.
- **Links:** [GitHub](https://github.com/opensolon/solon-ai)

### AWS SDK for Java v2 — Bedrock
- **Badge:** SDK
- **Description:** Official AWS SDK for Java v2 modules (`bedrockruntime`, `bedrockagentruntime`) for invoking Amazon Bedrock foundation models and Bedrock Agents from Java. Part of the actively-released `aws-sdk-java-v2` monorepo, joining the Google Gen AI, IBM watsonx.ai, and SAP AI Java SDKs already listed here.
- **Links:** [GitHub](https://github.com/aws/aws-sdk-java-v2) · [Maven Central](https://central.sonatype.com/artifact/software.amazon.awssdk/bedrockruntime)

### Qdrant Java Client
- **Badge:** Library
- **Description:** Official Java client for the Qdrant vector database — collection management, vector upsert, and similarity search over gRPC, with sync and async (`ListenableFuture`) support.
- **Links:** [GitHub](https://github.com/qdrant/java-client)

### Weaviate Java Client
- **Badge:** Library
- **Description:** Official Java client for the Weaviate vector database. The v6 line is a from-scratch rewrite for Weaviate ≥1.32, replacing the deprecated v5 client, with a "Tucked Builder" API for data ingestion, semantic search, filtering, and collection management.
- **Links:** [GitHub](https://github.com/weaviate/java-client) · [Docs](https://docs.weaviate.io/weaviate/client-libraries/java)

### Testcontainers Ollama Module
- **Badge:** Library
- **Description:** Official Testcontainers-for-Java module for spinning up disposable Ollama containers in integration tests — pull models and commit custom images for reuse. Commonly paired with Spring AI, LangChain4j, and Quarkus LangChain4j to test local-LLM code paths.
- **Links:** [Docs](https://java.testcontainers.org/modules/ollama/) · [GitHub](https://github.com/testcontainers/testcontainers-java/tree/main/modules/ollama)

### Camel LangChain4j Components
- **Badge:** Framework
- **Description:** Official Apache Camel components that let Camel routes call any LangChain4j-supported LLM. The chat component (since Camel 4.5) covers single, prompted, and multi-turn LLM calls with RAG enrichment; the agent component (since Camel 4.14) adds stateful/stateless AI agents that can invoke Camel routes as tools plus MCP client integration. Producer-only endpoints (`langchain4j-chat:id`, `langchain4j-agent:id`) fit naturally into existing integration pipelines. Camel 4.22 generalized tool exposure beyond LangChain4j: `camel-ai-tool` defines a route-as-tool once for use with LangChain4j, Spring AI, or OpenAI, and `camel-mcp-server` exposes tagged routes directly as MCP tools.
- **Links:** [Chat Component Docs](https://camel.apache.org/components/next/langchain4j-chat-component.html) · [Agent Component Docs](https://camel.apache.org/components/next/langchain4j-agent-component.html) · [GitHub](https://github.com/apache/camel)

### Google ADK for Kotlin
- **Badge:** Framework
- **Description:** Google's official Kotlin port of the Agent Development Kit — code-first orchestration of tools, agents, and multi-agent hierarchies in Kotlin, with an included dev UI for testing and evaluation. A companion Android flavor adds on-device agent support (Gemini Nano) with cloud fallback.
- **Links:** [Docs](https://adk.dev/) · [GitHub](https://github.com/google/adk-kotlin) · [Announcement](https://developers.googleblog.com/adk-kotlin-android-building-ai-agents/)

### LLM4S
- **Badge:** Framework
- **Description:** Scala 3 framework for building LLM applications — multi-provider support (OpenAI, Anthropic, Azure OpenAI, Gemini, DeepSeek, Cohere, Mistral, OpenRouter, Ollama), an agent framework with tool calling via ScalaMeta, RAG/vector stores, multimodal input, and OpenTelemetry/Langfuse tracing. Broader in scope than the site's other Scala entries (kyo-ai, zio-bedrock-converse) — closer to a "LangChain4j for Scala." Pre-1.0, MIT licensed, active development with weekly community dev-hours.
- **Links:** [Website](https://llm4s.org/) · [GitHub](https://github.com/llm4s/llm4s)

### Agents-Flex
- **Badge:** Framework
- **Description:** Lightweight Java AI application framework positioned as a Spring AI counterpart — unified abstractions for LLM calls, tool calling, agents (ReAct, routing, sub-agents), RAG with vector stores, MCP, a Skills system, and Text2SQL. Runs on plain Java, Spring Boot, or other JVM stacks (Java 8+). Apache 2.0, with frequent releases.
- **Links:** [GitHub](https://github.com/agents-flex/agents-flex)

### Spring AI Alibaba
- **Badge:** Framework
- **Description:** Alibaba Cloud's production-ready framework for agentic, workflow, and multi-agent Java applications, built on top of Spring AI. Graph-based orchestration (`SequentialAgent`, `ParallelAgent`, `RoutingAgent`, `LoopAgent`), multimodal ReactAgent support, MCP integration, and a built-in Admin observability/eval console. JDK 17+, Apache 2.0.
- **Links:** [GitHub](https://github.com/alibaba/spring-ai-alibaba)

---

## Java with Code Assistants

Technologies that supercharge Java development when paired with AI code assistants — from MCP servers that give agents live Javadoc access, to reusable skill packages and IDE integrations.

**Section focus:** Prioritize tools that bridge the gap between AI assistants and the Java ecosystem — MCP servers, skill registries, IDE plugins, and context providers — over general-purpose AI tools.

### AI-Git-Bot
- **Badge:** Assistant
- **Description:** Self-hosted AI workflow automation platform for Git repositories. Automates pull request reviews, test generation, issue management and documentation synchronization with the support of multiple AI backends. Pure Java application with a Spring-Boot based architecture.
- **Links:** [Website](https://gitbot.eu/) · [GitHub](https://github.com/tmseidel/ai-git-bot)

### Javadocs.dev MCP Server
- **Badge:** MCP Server
- **Description:** Gives AI assistants live access to Java, Kotlin, and Scala library documentation from Maven Central. Six tools including latest-version lookup, Javadoc symbol browsing, and source file retrieval. Connect any MCP client via Streamable HTTP.
- **Links:** website: https://www.javadocs.dev/

### JetBrains AI
- **Badge:** Assistant
- **Description:** AI-powered coding assistance built into IntelliJ IDEA and all JetBrains IDEs. Context-aware code completion, next-edit suggestions, and an agent-mode chat for refactoring, test generation, and complex tasks. Deep understanding of Java, Kotlin, and Scala project conventions. Supports cloud LLMs (Gemini, OpenAI, Anthropic) plus bring-your-own-key.
- **Links:** [Website](https://www.jetbrains.com/ai/) · [Docs](https://www.jetbrains.com/help/idea/ai-assistant.html)

### SkillsJars
- **Badge:** Skills
- **Description:** A packaging format and registry for distributing reusable AI agent skills as Maven/Gradle JARs. Skills are Markdown files (`SKILL.md`) under `META-INF/skills/` that teach AI agents domain-specific patterns. Discover and load skills on demand in Claude Code, Kiro, and Spring AI apps.
- **Links:** website: https://www.skillsjars.com/

### jvm-skills
- **Badge:** Skills
- **Description:** Curated directory of AI coding skills from JVM ecosystem engineers. Opinionated best-practice guides that AI tools (Claude Code, Cursor, Copilot) use as context — covering Spring Boot, jOOQ, Testcontainers, Docker, and more. Only lists skills that teach AI something it wouldn't know on its own.
- **Links:** [Website](https://jvmskills.com) · [GitHub](https://github.com/jvm-skills/jvm-skills)

### Awesome GitHub Copilot
- **Badge:** Skills
- **Description:** Awesome Copilot Skills is a curated registry of reusable AI agent skills that developers can plug into agents, providing ready-made capabilities, prompts, and workflows. It helps Java AI developers quickly extend agent functionality without building everything from scratch.
- **Links:** website: https://awesome-copilot.github.com/skills/?q=java

### jOOQ MCP Server
- **Badge:** MCP Server
- **Description:** Gives AI assistants live access to jOOQ documentation and examples. Connect any MCP client via Streamable HTTP.
- **Links:** website: https://jooq-mcp.martinelli.ch/

### Vaadin MCP Server
- **Badge:** MCP Server
- **Description:** Gives AI assistants live access to Vaadin documentation and examples. Connect any MCP client via Streamable HTTP.
- **Links:** website: https://mcp.vaadin.com/docs/

### Quarkus Agent MCP
- **Badge:** MCP Server
- **Description:** Official standalone MCP server from the Quarkus team that teaches AI coding agents to work with Quarkus applications — scaffolding new projects, controlling the app lifecycle, proxying Dev MCP tools, and searching Quarkus documentation. Runs as a separate process that survives app crashes, so agents can read logs and fix code after failures. Works with Claude Code, GitHub Copilot, Cursor, and JetBrains AI.
- **Links:** [Blog](https://quarkus.io/blog/introducing-agent-mcp/) · [GitHub](https://github.com/quarkusio/quarkus-agent-mcp)

### Open Liberty MCP Server
- **Badge:** MCP Server
- **Description:** Built-in Open Liberty runtime feature (`mcpServer-1.0`) that exposes Jakarta EE and CDI business logic as MCP tools for agentic AI workflows — role-based authorization, dynamic tool registration, and streamable transport. Actively developed through 2026 beta releases from IBM's Open Liberty team.
- **Links:** [Blog](https://openliberty.io/blog/2025/10/23/mcp-standalone-blog.html) · [Website](https://openliberty.io/)

### Maven Tools MCP
- **Badge:** MCP Server
- **Description:** Gives AI agents dependency intelligence from Maven Central — version lookup, upgrade comparisons, CVE and license health signals, and POM-aware resolution across Maven, Gradle, SBT, and Mill projects. Helps agents make safer automated dependency-upgrade decisions.
- **Links:** [GitHub](https://github.com/arvindand/maven-tools-mcp)

### JVM Pulse
- **Badge:** Extension
- **Description:** GitHub Copilot canvas extension that profiles a Java project's garbage collection and JFR telemetry — detects the build tool and JDK, runs a representative workload, and analyzes it with Microsoft's GCToolkit and the JDK `jfr` CLI. Surfaces throughput, pause times, heap usage, and allocation hot spots in an interactive dashboard, with an "Analyze with AI" hand-off into Copilot for tuning recommendations. Created by Bruno Borges. MIT license.
- **Links:** [GitHub](https://github.com/brunoborges/jvm-pulse) · [Blog](https://foojay.io/today/i-asked-github-copilot-to-profile-a-java-app-it-found-a-bug-in-my-heap-sizing-and-offered-to-fix-it/)

### IntelliJ IDEA MCP Server
- **Badge:** MCP Server
- **Description:** IntelliJ IDEA's built-in Model Context Protocol server, bundled and enabled by default since version 2025.2. Exposes over 100 IDE tools — code analysis, refactoring, debugging, run configurations, database operations — to external MCP clients like Claude Code, Claude Desktop, Cursor, and VS Code. Distinct from the JetBrains AI Assistant plugin above.
- **Links:** [Docs](https://www.jetbrains.com/help/idea/mcp-server.html)

### Apache Camel MCP Server
- **Badge:** MCP Server
- **Description:** Official MCP server shipped with Apache Camel 4.18 (`camel-jbang-mcp`). Exposes the live Camel and Kamelet catalogs, endpoint-URI validation, route understanding, and security analysis as 16 tools for AI coding assistants. Built on Quarkus, runs via JBang, supports STDIO and HTTP/SSE transports.
- **Links:** [Blog](https://camel.apache.org/blog/2026/02/camel-jbang-mcp/) · [Manual](https://camel.apache.org/manual/camel-jbang-mcp.html)

### Micronaut Fun MCP Server
- **Badge:** MCP Server
- **Description:** Official MCP server from the Micronaut project team giving AI assistants search access to Micronaut documentation and Guides via OpenSearch. Confirmed integrations for Claude Code, Claude Desktop, VS Code, cline, and IntelliJ IDEA.
- **Links:** [Website](https://micronaut.fun/) · [GitHub](https://github.com/micronaut-projects/micronaut-fun)

### Develocity MCP Servers
- **Badge:** MCP Server
- **Description:** Two official MCP servers from Gradle Inc.'s Develocity platform — one for per-build data (exceptions, stack traces, test outcomes, cache performance) to investigate failures, and an Analytics server for org-wide queries like flaky-test trends and cache effectiveness. Covers Gradle, Maven, sbt, and Bazel builds.
- **Links:** [Docs](https://docs.develocity.ai/2026.1/integrations/mcp-servers/)

### AssistAI (Eclipse IDE MCP Server)
- **Badge:** Extension
- **Description:** Community Eclipse IDE plugin (formerly "eclipse-chatgpt-plugin") that exposes the Eclipse workspace as an MCP server — code analysis, refactoring, build/debug control, and Git operations via EGit — so external AI agents like Claude Code edit through Eclipse's JDT APIs instead of the raw filesystem, keeping incremental compilation and error highlighting in sync. Also bundles an inline AI chat view. MIT licensed.
- **Links:** [Eclipse Marketplace](https://marketplace.eclipse.org/content/assistai-eclipse-ide-mcp-server-ai-agents) · [GitHub](https://github.com/gradusnikov/eclipse-chatgpt-plugin)

### SonarQube MCP Server
- **Badge:** MCP Server
- **Description:** Official MCP server from SonarSource exposing SonarQube Cloud/Server code-quality and security analysis to AI coding agents — issue management, security hotspots, quality gates, coverage, and dependency risk across 50+ tools. Distributed as a Docker image.
- **Links:** [GitHub](https://github.com/SonarSource/sonarqube-mcp-server)

### TDA (Thread Dump Analyzer)
- **Badge:** MCP Server
- **Description:** JVM diagnostics tool for analyzing thread dumps and heap data — deadlocks, bottlenecks, virtual-thread pinning — across JDK 1.4–21+. Usable as a standalone Swing GUI, a JConsole/VisualVM plugin, or a headless MCP server for AI tools like Claude and Cursor.
- **Links:** [GitHub](https://github.com/irockel/tda)

### SolonCode
- **Badge:** Assistant
- **Description:** Open-source, provider-agnostic AI coding agent built on the Solon-AI framework, targeting Java 8–26 runtimes. CLI, web, and desktop-IDE interfaces with auto-edit, approval-based execution, and planning agent modes — an open alternative to Claude Code.
- **Links:** [GitHub](https://github.com/opensolon/soloncode)

### Junie
- **Badge:** Assistant
- **Description:** JetBrains' autonomous coding agent — plans and executes multi-step edits, runs tests and the debugger, and opens PRs. Reached GA in June 2026 with a standalone bring-your-own-key CLI (Anthropic, OpenAI, Google, xAI, OpenRouter, Copilot) alongside its JetBrains IDE integration. Distinct from the general-purpose JetBrains AI Assistant above.
- **Links:** [Docs](https://www.jetbrains.com/help/ai-assistant/junie-agent.html) · [Marketplace](https://plugins.jetbrains.com/plugin/26104-junie-the-ai-coding-agent-by-jetbrains)

---

## Inference & Training

Run models, train classifiers, and do ML inference directly on the JVM — no Python required.
### Deliverance
- **Badge:** Inference
- **Description:** Deliverance is a Java inference engine capable of generating text, tokenizing input, computing embeddings, and more. Can be used as embedded library inside your Java application or as an HTTP server /chat/completion). Deliverance also provides chat and Rag Chat through vibrant-maven-plugin allowing you to chat with your code!
- **Links:** [GitHub](https://github.com/edwardcapriolo/deliverance) [Dockerhub](https://hub.docker.com/repository/docker/ecapriolo/deliverance/general)

### Jlama
- **Badge:** Inference
- **Description:** ⚠️ No longer actively maintained. Modern LLM inference engine written in pure Java. Runs Llama, Gemma, Mistral, and more locally on CPU. Uses Java's Vector API (Project Panama) for SIMD-accelerated matrix math. Supports SafeTensors format, quantized models, and distributed inference.
- **Links:** [GitHub](https://github.com/tjake/Jlama) · [Tutorial](https://www.baeldung.com/java-jlama-llm)

### Deep Java Library (DJL)
- **Badge:** Inference
- **Description:** AWS's high-level, engine-agnostic deep learning framework. Supports PyTorch, TensorFlow, ONNX Runtime, and XGBoost backends. DJLServing provides high-performance model serving.
- **Links:** [GitHub](https://github.com/deepjavalibrary/djl) · [InfoQ](https://www.infoq.com/articles/java-machine-learning-djl/)

### ONNX Runtime Java
- **Badge:** Inference
- **Description:** Run transformer and classical ML models directly on the JVM. Hardware acceleration via CUDA, DirectML, CoreML, and more. Enables deploying scikit-learn, PyTorch, and HuggingFace models as ONNX in Java without Python at inference time.
- **Links:** [Docs](https://onnxruntime.ai/docs/get-started/with-java.html) · [InfoQ Guide](https://www.infoq.com/articles/onnx-ai-inference-with-java/)

### Tribuo
- **Badge:** Training
- **Description:** Oracle Labs' ML library for classification, regression, clustering, and anomaly detection. Strong typing, provenance tracking for reproducibility, and integrations with XGBoost, ONNX Runtime, TensorFlow, and LibSVM.
- **Links:** [Website](https://tribuo.org/) · [GitHub](https://github.com/oracle/tribuo)

### GPULlama3.java
- **Badge:** Inference
- **Description:** Java-native LLM inference with automatic GPU acceleration via TornadoVM. Supports Llama 3, Mistral, Qwen, Phi-3, and IBM Granite models in GGUF format. TornadoVM translates Java bytecode to GPU kernels (OpenCL, PTX, SPIR-V). From the University of Manchester's Beehive Lab.
- **Links:** [InfoQ](https://www.infoq.com/news/2025/06/gpullama3-java-gpu-llm/)

### TornadoVM
- **Badge:** Inference
- **Description:** GPU programming framework for Java — JIT-compiles Java bytecode into CUDA, OpenCL, and Apple Metal at runtime, running on GPUs and multi-core CPUs. Powers GPULlama3.java's GPU acceleration. v5.2.0 added AI-focused kernels: native FP8 conversion, FP8/BF16 tensor-core matrix multiply, cuBLAS/CUTLASS-compatible BFloat16 arrays, and batched FP16 GEMM. From the University of Manchester's Beehive Lab.
- **Links:** [Website](https://www.tornadovm.org) · [GitHub](https://github.com/beehive-lab/TornadoVM) · [Docs](https://tornadovm.readthedocs.io/en/latest/)

### TensorFlow Java
- **Badge:** Training
- **Description:** Java bindings for TensorFlow, maintained by the TensorFlow JVM SIG. Train and deploy TF models entirely in Java. Available as an optional Tribuo integration. Suitable for teams that want to stay within the JVM ecosystem while using TensorFlow's model formats.
- **Links:** [Docs](https://www.tensorflow.org/jvm) · [GitHub](https://github.com/tensorflow/java)

### Eclipse Deeplearning4j (DL4J)
- **Badge:** Training
- **Description:** Long-standing JVM deep-learning suite — DL4J for model building, ND4J for linear algebra, SameDiff for automatic differentiation, and DataVec for ETL. GPU/CPU acceleration and distributed training via Spark, plus model import from Keras, TensorFlow, and ONNX/PyTorch. Maintained by Konduit under the Eclipse Foundation.
- **Links:** [Website](https://deeplearning4j.konduit.ai/) · [GitHub](https://github.com/deeplearning4j/deeplearning4j)

### Apache OpenNLP
- **Badge:** Training
- **Description:** Apache's Java-native NLP toolkit — tokenization, part-of-speech tagging, named entity recognition, chunking, parsing, and language detection, with pluggable MaxEnt, Perceptron, Naive Bayes, and SVM classifiers. Actively maintained, with a Java 21-targeted 3.0 branch in progress.
- **Links:** [Website](https://opennlp.apache.org) · [GitHub](https://github.com/apache/opennlp)

---

## People to Follow

Key voices at the intersection of Java and AI.
Notes:
- Alphabetical by last name
- Indicate if someone is a Java Champion using a badge on its own line (below the name, above the role). Don't repeat "Java Champion" in the role text. Lookup: https://github.com/aalmiray/java-champions/blob/main/java-champions.yml
- Add profile photos if found.
- Add Twitter, GitHub, LinkedIn, Bluesky, YouTube, if available.

### Sandra Ahlgrimm

- **Badge:** Person
- **Initials:** SA
- **Photo:** https://avatars.githubusercontent.com/u/5214683?v=4
- **Role:** Senior Cloud Advocate for Java — Microsoft/GitHub; focused on GitHub Copilot for Java developers and LangChain4j integrations, co-leads a local JUG, and represents Microsoft on the GraalVM Program Advisory Board
- **Links:** [GitHub](https://github.com/sandraahlgrimm) · [LinkedIn](https://www.linkedin.com/in/sandraahlgrimm/)

### Jean-François Arcand

- **Badge:** Person
- **Java Champion**
- **Initials:** JA
- **Photo:** https://avatars.githubusercontent.com/u/51285?v=4
- **Role:** Creator of the original Atmosphere Framework, Grizzly, and AsyncHttpClient; now building the new Atmosphere real-time transport layer for Java AI agents
- **Links:** [@jfarcand](https://twitter.com/jfarcand) · [GitHub](https://github.com/jfarcand) · [LinkedIn](https://www.linkedin.com/in/jfarcand/)

### Zineb Bendhiba

- **Badge:** Person
- **Initials:** ZB
- **Photo:** https://avatars.githubusercontent.com/u/12056979?v=4
- **Role:** Principal Software Engineer — IBM; Apache Camel PMC member, maintains Camel Quarkus and Quarkus Qdrant, lead author of Camel 4.22's `camel-ai-tool` and `camel-mcp-server`
- **Links:** [@ZinebBendhiba](https://x.com/ZinebBendhiba) · [Bluesky](https://bsky.app/profile/zinebbendhiba.com) · [GitHub](https://github.com/zbendhiba) · [LinkedIn](https://www.linkedin.com/in/zbendhiba/) · [Website](https://zinebbendhiba.com/)

### Bruno Borges

- **Badge:** Person
- **Java Champion**
- **Initials:** BB
- **Photo:** https://avatars.githubusercontent.com/u/129743?v=4
- **Role:** Principal Program Manager — Microsoft Java Engineering Group
- **Links:** [@brunoborges](https://twitter.com/brunoborges) · [Bluesky](https://bsky.app/profile/brunoborges.bsky.social) · [GitHub](https://github.com/brunoborges) · [LinkedIn](https://ca.linkedin.com/in/brunocborges) · [Blog](https://blog.brunoborges.info/)

### Vadim Briliantov

- **Badge:** Person
- **Initials:** VB
- **Photo:** https://avatars.githubusercontent.com/u/24360128?v=4
- **Role:** Technical Lead of Koog / AI Agents Platform — JetBrains
- **Links:** [GitHub](https://github.com/Ololoshechkin) · [LinkedIn](https://hu.linkedin.com/in/vadim-briliantov) · [Blog](https://medium.com/@vadim.briliantov)

### Holly Cummins

- **Badge:** Person
- **Java Champion**
- **Initials:** HC
- **Photo:** https://avatars.githubusercontent.com/u/11509290?v=4
- **Role:** Senior Principal Software Engineer — IBM Quarkus team
- **Links:** [@holly_cummins](https://twitter.com/holly_cummins) · [Bluesky](https://bsky.app/profile/hollycummins.com) · [GitHub](https://github.com/holly-cummins) · [LinkedIn](https://linkedin.com/in/holly-k-cummins/) · [Website](https://hollycummins.com)

### Eric Deandrea

- **Badge:** Person
- **Java Champion**
- **Initials:** ED
- **Photo:** https://avatars.githubusercontent.com/u/363447?v=4
- **Role:** [Docling Java](https://docling-project.github.io/docling-java/current) project lead, contributor to LangChain4j, Sr. Principal Software Engineer at IBM
- **Links:** [Bluesky](https://bsky.app/profile/ericdeandrea.dev) · [@edeandrea](https://x.com/edeandrea) · [GitHub](https://github.com/edeandrea) · [LinkedIn](https://www.linkedin.com/in/edeandrea/)

### Ronald Dehuysser

- **Badge:** Person
- **Initials:** RD
- **Photo:** https://avatars.githubusercontent.com/u/567842?v=4
- **Role:** Creator of JobRunr and ClawRunr
- **Links:** [@rdehuyss](https://twitter.com/rdehuyss) · [GitHub](https://github.com/rdehuyss) · [LinkedIn](https://www.linkedin.com/in/ronalddehuysser)

### Sébastien Deleuze

- **Badge:** Person
- **Initials:** SD
- **Photo:** https://avatars.githubusercontent.com/u/141109?v=4
- **Role:** Spring Framework core committer, Spring AI/MCP integration — Broadcom
- **Links:** [@sdeleuze](https://x.com/sdeleuze) · [Bluesky](https://bsky.app/profile/seb.deleuze.fr) · [GitHub](https://github.com/sdeleuze) · [LinkedIn](https://www.linkedin.com/in/deleuze) · [Blog](https://seb.deleuze.fr)

### Iryna Dohndorf

- **Badge:** Person
- **Dr.-Ing.**
- **Initials:** ID
- **Photo:** https://avatars.githubusercontent.com/u/79046580?v=4
- **Role:** Creator of Tiberius - Java security and safety testing framework for LLM applications; software engineer at Karakun; her work sits at the intersection of Java engineering, AI safety, and antifragile system design
- **Links:** [GitHub](https://github.com/IDohndorf) · [LinkedIn](https://www.linkedin.com/in/iryna-dohndorf/) · [Website](https://iryna-dohndorf.netlify.app/)

### Julien Dubois

- **Badge:** Person
- **Java Champion**
- **Initials:** JD
- **Photo:** https://avatars.githubusercontent.com/u/316835?v=4
- **Role:** Creator of JHipster; leads a Developer Relations team at Microsoft focused on agentic developer tools for Java/Spring Boot
- **Links:** [@juliendubois](https://twitter.com/juliendubois) · [Bluesky](https://bsky.app/profile/jdubois.bsky.social) · [GitHub](https://github.com/jdubois) · [LinkedIn](https://www.linkedin.com/in/juliendubois/) · [Website](https://www.julien-dubois.com/)

### Markus Eisele

- **Badge:** Person
- **Java Champion**
- **Initials:** ME
- **Photo:** https://avatars.githubusercontent.com/u/1358554?v=4
- **Role:** Developer Advocate — IBM Research, JavaLand founder
- **Links:** [@myfear](https://twitter.com/myfear) · [Bluesky](https://bsky.app/profile/myfear.com) · [GitHub](https://github.com/myfear) · [LinkedIn](https://www.linkedin.com/in/markuseisele/) · [Blog](https://blog.eisele.net/)

### Mario Fusco

- **Badge:** Person
- **Java Champion**
- **Initials:** MF
- **Photo:** https://avatars.githubusercontent.com/u/372781?v=4
- **Role:** LangChain4j core team, Sr. Principal Software Engineer at IBM
- **Links:** [@mariofusco](https://x.com/mariofusco) · [GitHub](https://github.com/mariofusco) · [LinkedIn](https://www.linkedin.com/in/mario-fusco-3467213/)

### Antonio Goncalves

- **Badge:** Person
- **Java Champion**
- **Initials:** AG
- **Photo:** https://avatars.githubusercontent.com/u/729277?v=4
- **Role:** Principal Software Engineer at Microsoft CoreAI, ParisJUG, Devoxx France, Café IA, book author
- **Links:** [@agoncal](https://twitter.com/agoncal) · [Bluesky](https://bsky.app/profile/agoncal.bsky.social) · [GitHub](https://github.com/agoncal) · [LinkedIn](https://www.linkedin.com/in/agoncal/) · [Blog](https://antoniogoncalves.org)

### Frank Greco

- **Badge:** Person
- **Java Champion**
- **Initials:** FG
- **Photo:** https://avatars.githubusercontent.com/u/193434?v=4
- **Role:** NYJavaSIG founder, AI 4 Java educator, JSR 381 co-author
- **Links:** [@frankgreco](https://twitter.com/frankgreco) · [Bluesky](https://bsky.app/profile/frankgreco.bsky.social) · [GitHub](https://github.com/fgreco55) · [LinkedIn](https://www.linkedin.com/in/frankdgreco/) · [Website](https://ai4java.com)

### Ivar Grimstad

- **Badge:** Person
- **Java Champion**
- **Initials:** IG
- **Photo:** https://avatars.githubusercontent.com/u/149188?v=4
- **Role:** Jakarta EE Developer Advocate — Eclipse Foundation; speaks on bringing AI to Jakarta EE (Jakarta Agentic AI)
- **Links:** [@ivar_grimstad](https://twitter.com/ivar_grimstad) · [Bluesky](https://bsky.app/profile/theguywiththeduketattoo.com) · [GitHub](https://github.com/ivargrimstad) · [LinkedIn](https://www.linkedin.com/in/ivargrimstad/) · [Website](https://www.agilejava.eu)

### Rod Johnson

- **Badge:** Person
- **Java Champion**
- **Initials:** RJ
- **Photo:** https://avatars.githubusercontent.com/u/1916583?v=4
- **Role:** Creator of Spring Framework, CEO of Embabel
- **Links:** [@springrod](https://twitter.com/springrod) · [GitHub](https://github.com/johnsonr) · [LinkedIn](https://www.linkedin.com/in/johnsonroda/) · [Blog](https://medium.com/@springrod)

### Daniel Kec

- **Badge:** Person
- **Initials:** DK
- **Photo:** https://avatars.githubusercontent.com/u/1773630?v=4
- **Role:** Helidon developer — Oracle
- **Links:** [@danielkec](https://twitter.com/danielkec) · [Bluesky](https://bsky.app/profile/kec.bsky.social) · [GitHub](https://github.com/danielkec) · [LinkedIn](https://www.linkedin.com/in/danielkec/)

### Kenneth Kousen

- **Badge:** Person
- **Java Champion**
- **Initials:** KK
- **Photo:** https://avatars.githubusercontent.com/u/22784?v=4
- **Role:** Author of six books including *Kotlin Cookbook* and *Modern Java Recipes*. O'Reilly instructor for AI + Java courses. Professor of Practice in Computer Science at Trinity College. President of Kousen IT, Inc.
- **Links:** [@kenkousen](https://twitter.com/kenkousen) · [Bluesky](https://bsky.app/profile/kousenit.com) · [GitHub](https://github.com/kousen) · [LinkedIn](https://www.linkedin.com/in/kenkousen/) · [Website](https://www.kousenit.com/) · [Newsletter](https://kenkousen.substack.com) · [YouTube](https://youtube.com/@talesfromthejarside)

### Guillaume Laforge

- **Badge:** Person
- **Java Champion**
- **Initials:** GL
- **Photo:** https://avatars.githubusercontent.com/u/47907?v=4
- **Role:** Google Developer Advocate — Java, Groovy, AI
- **Links:** [@glaforge](https://twitter.com/glaforge) · [Bluesky](https://bsky.app/profile/glaforge.bsky.social) · [GitHub](https://github.com/glaforge) · [LinkedIn](https://www.linkedin.com/in/glaforge/) · [Blog](https://glaforge.dev/)

### Dmytro Liubarskyi

- **Badge:** Person
- **Initials:** DL
- **Photo:** https://avatars.githubusercontent.com/u/3154404?v=4
- **Role:** Creator of LangChain4j, Principal Architect — IBM
- **Links:** [Bluesky](https://bsky.app/profile/dmythro.bsky.social) · [GitHub](https://github.com/dliubarskyi) · [LinkedIn](https://www.linkedin.com/in/dmytro-liubarskyi/)

### Josh Long

- **Badge:** Person
- **Java Champion**
- **Initials:** JL
- **Photo:** https://avatars.githubusercontent.com/u/54473?v=4
- **Role:** Spring Developer Advocate at Broadcom
- **Links:** [@starbuxman](https://twitter.com/starbuxman) · [Bluesky](https://bsky.app/profile/starbuxman.joshlong.com) · [GitHub](https://github.com/joshlong) · [LinkedIn](https://www.linkedin.com/in/joshlong/) · [Spring Blog](https://spring.io/authors/joshlong/)

### T. Jake Luciani

- **Badge:** Person
- **Initials:** TK
- **Photo:** https://avatars.githubusercontent.com/u/44456?v=4
- **Role:** Creator of Jlama — Java LLM inference
- **Links:** [@tjake](https://twitter.com/tjake) · [GitHub](https://github.com/tjake) · [LinkedIn](https://www.linkedin.com/in/tjake/)

### Loïc Magnette

- **Badge:** Person
- **Initials:** LM
- **Photo:** https://avatars.githubusercontent.com/u/6390187?v=4
- **Role:** Senior Software Engineer — Oniryx; BeJUG (Belgian Java User Group) co-organizer, writes and speaks on LangChain4j agentic workflows for Quarkus
- **Links:** [@LoMagnette](https://x.com/LoMagnette) · [Bluesky](https://bsky.app/profile/lomagnette.bsky.social) · [GitHub](https://github.com/lomagnette) · [LinkedIn](https://www.linkedin.com/in/lomagnette/) · [Blog](https://lomagnette.github.io/)

### François Martin

- **Badge:** Person
- **Initials:** FM
- **Photo:** https://avatars.githubusercontent.com/u/14319020?v=4
- **Role:** International speaker and author, Oracle ACE Associate, senior full-stack software engineer
- **Links:** [@fmartin_](https://x.com/fmartin_) · [GitHub](https://github.com/martinfrancois) · [LinkedIn](https://www.linkedin.com/in/fran%c3%a7oismartin/) · [Bluesky](https://bsky.app/profile/fmartin.ch) · [YouTube](https://www.youtube.com/@fmartindev) · [Website](https://fmartin.ch)

### Simon Martinelli

- **Badge:** Person
- **Initials:** MP
- **Photo:** https://avatars.githubusercontent.com/u/593352?v=4
- **Role:** Creator of AI Unfied Process and jOOQ MCP Server
- **Links:** [@simas_ch](https://twitter.com/simas_ch) · [GitHub](https://github.com/simach) · [LinkedIn](https://www.linkedin.com/in/simonmartinelli/)

### Ana-Maria Mihalceanu

- **Badge:** Person
- **Java Champion**
- **Initials:** AM
- **Photo:** https://avatars.githubusercontent.com/u/9703337?v=4
- **Role:** Senior Developer Advocate, Java Platform Group at Oracle; writes and speaks on Java MCP tooling and AI, co-founder of the Bucharest Software Craftsmanship Community
- **Links:** [@ammbra1508](https://twitter.com/ammbra1508) · [GitHub](https://github.com/ammbra) · [LinkedIn](https://www.linkedin.com/in/ana-maria-mihalceanu-1508/)

### Vishal Mysore

- **Badge:** Person
- **Initials:** VM
- **Photo:** https://avatars.githubusercontent.com/u/25938717?v=4
- **Role:** Creator of Tools4AI
- **Links:** [GitHub](https://github.com/vishalmysore) · [LinkedIn](https://www.linkedin.com/in/vishalrow/) · [Blog](https://medium.com/@visrow)

### Daniel Oh

- **Badge:** Person
- **Java Champion**
- **Initials:** DO
- **Photo:** https://avatars.githubusercontent.com/u/14066977?v=4
- **Role:** Senior Principal Developer Advocate — Red Hat; CNCF Ambassador speaking on agentic AI and cloud-native Java
- **Links:** [@danieloh30](https://twitter.com/danieloh30) · [Bluesky](https://bsky.app/profile/danieloh30.bsky.social) · [LinkedIn](https://www.linkedin.com/in/daniel-oh-083818112/)

### Michalis Papadimitriou

- **Badge:** Person
- **Initials:** MP
- **Photo:** https://avatars.githubusercontent.com/u/8652854?v=4
- **Role:** Research Fellow, University of Manchester and Senior Software Engineer at Neo4j; TornadoVM core maintainer and lead author of GPULlama3.java, GPU-accelerated LLM inference in pure Java
- **Links:** [GitHub](https://github.com/mikepapadim) · [LinkedIn](https://www.linkedin.com/in/michalis-papadimitriou/) · [Website](https://mpapadimitriou.com/)

### Konstantin Pavlov

- **Badge:** Person
- **Initials:** KP
- **Photo:** https://avatars.githubusercontent.com/u/1517853?v=4
- **Role:** Creator of Tachyon; maintainer of mokksy.dev and LangChain4j Kotlin extensions
- **Links:** [Bluesky](https://bsky.app/profile/kpavlov.me) · [GitHub](https://github.com/kpavlov) · [Blog](https://kpavlov.me)

### Susanne Pieterse

- **Badge:** Person
- **Initials:** SP
- **Photo:** https://avatars.githubusercontent.com/u/18641509?v=4
- **Role:** Senior Software Engineer & iSAQB-certified Software Architect — OPEN.nl; LangChain4j contributor teaching Java teams to build reliable AI agents
- **Links:** [Bluesky](https://bsky.app/profile/susivic.bsky.social) · [GitHub](https://github.com/Sus4nne)

### Mark Pollack

- **Badge:** Person
- **Initials:** MP
- **Photo:** https://avatars.githubusercontent.com/u/247466?v=4
- **Role:** Spring AI project lead
- **Links:** [@markpollack](https://twitter.com/markpollack) · [GitHub](https://github.com/markpollack) · [LinkedIn](https://www.linkedin.com/in/marklpollack/)

### Lize Raes

- **Badge:** Person
- **Initials:** LR
- **Photo:** https://avatars.githubusercontent.com/u/49833622?v=4
- **Role:** LangChain4j core team, Developer Advocate at Oracle
- **Links:** [@LizeRaes](https://twitter.com/LizeRaes) · [GitHub](https://github.com/LizeRaes) · [LinkedIn](https://www.linkedin.com/in/lize-raes-a8a34110/)

### Reza Rahman

- **Badge:** Person
- **Java Champion**
- **Initials:** RR
- **Photo:** https://avatars.githubusercontent.com/u/3622346?v=4
- **Role:** Jakarta Agentic AI project lead at Payara/Azul, Jakarta EE Ambassadors founder
- **Links:** [GitHub](https://github.com/m-reza-rahman) · [LinkedIn](https://www.linkedin.com/in/javareza) · [Website](https://reza-rahman.me)

### K. Siva Prasad Reddy

- **Badge:** Person
- **Initials:** SR
- **Photo:** https://avatars.githubusercontent.com/u/542428?v=4
- **Role:** Developer Advocate at JetBrains, author of *Beginning Spring Boot 3*
- **Links:** [@sivalabs](https://twitter.com/sivalabs) · [GitHub](https://github.com/sivaprasadreddy) · [LinkedIn](https://in.linkedin.com/in/ksivaprasadreddy) · [YouTube](https://youtube.com/sivalabs) · [Blog](https://sivalabs.in)

### Jennifer Reif

- **Badge:** Person
- **Java Champion**
- **Initials:** JR
- **Photo:** https://avatars.githubusercontent.com/u/14850786?v=4
- **Role:** Developer Advocate at Neo4j
- **Links:** [@JMHReif](https://twitter.com/JMHReif) · [GitHub](https://github.com/JMHReif) · [LinkedIn](https://www.linkedin.com/in/jmhreif/) · [Website](https://jmhreif.com)

### Baruch Sadogursky

- **Badge:** Person
- **Java Champion**
- **Initials:** BS
- **Photo:** https://avatars.githubusercontent.com/u/247332?v=4
- **Role:** Developer Advocate at Tessl, co-author of *Liquid Software* and *DevOps Tools for Java Developers*
- **Links:** [@jbaruch](https://twitter.com/jbaruch) · [Bluesky](https://bsky.app/profile/jbaru.ch) · [GitHub](https://github.com/jbaruch) · [LinkedIn](https://www.linkedin.com/in/jbaruch/) · [Website](https://speaking.jbaru.ch)

### Timo Salm

- **Badge:** Person
- **Initials:** TS
- **Photo:** https://avatars.githubusercontent.com/u/52704922?v=4
- **Role:** Principal Solutions Engineer, VMware Tanzu at Broadcom; frequent conference speaker comparing Java agentic-AI frameworks (Spring AI, LangChain4j, Embabel)
- **Links:** [@salmto](https://twitter.com/salmto) · [GitHub](https://github.com/timosalm) · [LinkedIn](https://www.linkedin.com/in/timosalm)

### Otavio Santana

- **Badge:** Person
- **Java Champion**
- **Initials:** OS
- **Photo:** https://avatars.githubusercontent.com/u/863011?v=4
- **Role:** Jakarta Data/Jakarta NoSQL spec lead, Eclipse JNoSQL creator, writes on building AI agents with Jakarta EE and LangChain4j
- **Links:** [@otaviojava](https://twitter.com/otaviojava) · [GitHub](https://github.com/otaviojava) · [LinkedIn](https://www.linkedin.com/in/otaviojava/) · [Website](https://otaviojava.com/) · [YouTube](https://www.youtube.com/@otaviojava)

### Oleg Šelajev

- **Badge:** Person
- **Java Champion**
- **Initials:** OŠ
- **Photo:** https://avatars.githubusercontent.com/u/426039?v=4
- **Role:** Developer Relations Lead for AI — Docker
- **Links:** [@shelajev](https://twitter.com/shelajev) · [GitHub](https://github.com/shelajev) · [LinkedIn](https://www.linkedin.com/in/shelajev/)

### Zoran Sevarac

- **Badge:** Person
- **Java Champion**
- **Initials:** ZS
- **Photo:** https://avatars.githubusercontent.com/u/158153?v=4
- **Role:** Associate Professor, University of Belgrade; creator of Deep Netts and Neuroph, pure-Java deep learning libraries, and JSR-381 (Visual Recognition API) co-lead
- **Links:** [GitHub](https://github.com/sevarac) · [LinkedIn](https://www.linkedin.com/in/zoran-sevarac-phd-49a9a411/) · [Website](https://www.zoransevarac.com/)

### Bartosz Sorrentino

- **Badge:** Person
- **Initials:** BS
- **Photo:** https://avatars.githubusercontent.com/u/301596?v=4
- **Role:** LangGraph4j creator, Principal Software Architect
- **Links:** [@bsorrentinoJ](https://twitter.com/bsorrentinoJ) · [GitHub](https://github.com/bsorrentino) · [LinkedIn](https://www.linkedin.com/in/bartolomeosorrentino/)

### Alex Soto Bueno

- **Badge:** Person
- **Java Champion**
- **Initials:** AS
- **Photo:** https://avatars.githubusercontent.com/u/1517153?v=4
- **Role:** Director of Developer Experience — Red Hat, co-author of "AI Agents with Java" (O'Reilly)
- **Links:** [@alexsotob](https://twitter.com/alexsotob) · [GitHub](https://github.com/lordofthejars) · [Blog](https://www.lordofthejars.com)

### Venkat Subramaniam

- **Badge:** Person
- **Java Champion**
- **Initials:** VS
- **Photo:** https://avatars.githubusercontent.com/u/5804?v=4
- **Role:** Founder of Agile Developer, creator of the dev2next and Arc of AI conferences, award-winning author and instructor at the University of Houston
- **Links:** [@venkat_s](https://twitter.com/venkat_s) · [Bluesky](https://bsky.app/profile/venkats.bsky.social) · [GitHub](https://github.com/venkats) · [LinkedIn](https://www.linkedin.com/in/vsubramaniam/)

### Christian Tzolov

- **Badge:** Person
- **Initials:** CT
- **Photo:** https://avatars.githubusercontent.com/u/1351573?v=4
- **Role:** Spring AI lead, MCP Java SDK founder, Spring team at Broadcom
- **Links:** [@christzolov](https://twitter.com/christzolov) · [Bluesky](https://bsky.app/profile/tzolov.bsky.social) · [GitHub](https://github.com/tzolov) · [LinkedIn](https://www.linkedin.com/in/tzolov/)

### Dan Vega

- **Badge:** Person
- **Java Champion**
- **Initials:** DV
- **Photo:** https://avatars.githubusercontent.com/u/349507?v=4
- **Role:** Spring Developer Advocate, YouTube educator
- **Links:** [@therealdanvega](https://twitter.com/therealdanvega) · [Bluesky](https://bsky.app/profile/danvega.dev) · [GitHub](https://github.com/danvega) · [LinkedIn](https://www.linkedin.com/in/danvega/) · [Blog](https://www.danvega.dev/)

### Dmitry Vinnik

- **Badge:** Person
- **Initials:** DV
- **Photo:** https://avatars.githubusercontent.com/u/12485205?v=4
- **Role:** Lead Developer Advocate at Meta
- **Links:** [@DmitryVinnik](https://twitter.com/DmitryVinnik) · [GitHub](https://github.com/dmitryvinn) · [LinkedIn](https://www.linkedin.com/in/dmitry-vinnik/) · [Blog](https://dvinnik.dev/)

### Thomas Vitale

- **Badge:** Person
- **Java Champion**
- **Initials:** TV
- **Photo:** https://avatars.githubusercontent.com/u/8523418?v=4
- **Role:** Spring AI Lead Contributor, creator of Arconia, author of *Cloud Native Spring in Action*
- **Links:** [@vitalethomas](https://x.com/vitalethomas) · [Bluesky](https://bsky.app/profile/thomasvitale.com) · [GitHub](https://github.com/ThomasVitale) · [LinkedIn](https://www.linkedin.com/in/vitalethomas/) · [Website](https://www.thomasvitale.com)

### Craig Walls

- **Badge:** Person
- **Java Champion**
- **Initials:** CW
- **Photo:** https://avatars.githubusercontent.com/u/167926?v=4
- **Role:** Author of *Spring AI in Action*
- **Links:** [@habuma](https://twitter.com/habuma) · [Bluesky](https://bsky.app/profile/habuma.com) · [GitHub](https://github.com/habuma) · [LinkedIn](https://www.linkedin.com/in/habuma)

### James Ward

- **Badge:** Person
- **Java Champion**
- **Initials:** JW
- **Photo:** https://avatars.githubusercontent.com/u/65043?v=4
- **Role:** Developer Advocate — Java, Kotlin, Cloud, AI
- **Links:** [@_JamesWard](https://twitter.com/_jamesward) · [Bluesky](https://bsky.app/profile/jamesward.com) · [GitHub](https://github.com/jamesward) · [LinkedIn](https://www.linkedin.com/in/jamesward) · [Blog](https://jamesward.com)

### Pascal Wilbrink

- **Badge:** Person
- **Initials:** PW
- **Photo:** https://avatars.githubusercontent.com/u/5970214?v=4
- **Role:** Senior Software Developer — OpenValue; creator of the Spring AI AG-UI Java SDK, bringing the AG-UI protocol to Java/Spring AI
- **Links:** [GitHub](https://github.com/pascalwilbrink) · [Website](https://pascalwilbrink.github.io)

---

## FAQ

Frequently asked questions about AI development on the JVM. Rendered as a Q&A list. Include matching `FAQPage` structured data in the page `<head>`.

### What is the best Java framework for building AI agents?
The most popular choices are Spring AI and LangChain4j. Spring AI is ideal if you're already in the Spring ecosystem, offering portable abstractions across 20+ model providers. LangChain4j provides a standalone library with three levels of abstraction, from low-level prompts to high-level AI Services. Other options include Google ADK for Java, Embabel, and Akka Agents — each with different strengths for specific use cases.

### Can Java run LLMs locally?
Yes. Projects like Jlama and GPULlama3.java run Llama, Mistral, and other models directly on the JVM. Jlama uses Java's Vector API for SIMD-accelerated inference on CPU, while GPULlama3.java leverages TornadoVM for GPU acceleration. For production deployments, ONNX Runtime Java supports hardware-accelerated inference across CUDA, DirectML, and CoreML.

### What is MCP and how does it work with Java?
The Model Context Protocol (MCP) is an open standard that lets AI assistants interact with external tools and data sources. The official MCP Java SDK, maintained by the Spring AI team, provides both client and server implementations with sync/async support and multiple transports (STDIO, Streamable HTTP; SSE deprecated as of 2.0). Helidon MCP and several frameworks also offer MCP support.

### Is Kotlin supported by Java AI frameworks?
Yes. Most Java AI frameworks run on any JVM language. Embabel is written in Kotlin with full Java interop, Koog from JetBrains is a Kotlin-native agent framework, and Tracy provides AI observability for Kotlin. LangChain4j and Spring AI work seamlessly from Kotlin code.

---

## Recent & Noteworthy Content, Communities, and Resources

### Java Conferences Tracker

- **Badge:** Community
- **Description:** Community-maintained calendar of all Java conferences worldwide
- **Links:** [Website](https://javaconferences.org/)

### Java Relevance in the AI Era

- **Badge:** Blog
- **Description:** RedMonk analysis of Java's position as agent frameworks emerge
- **Links:** [Article](https://redmonk.com/jgovernor/java-relevance-in-the-ai-era-agent-frameworks-emerge/)

### Awesome Spring AI

- **Badge:** Resource
- **Description:** Curated list of Spring AI resources, tools, and tutorials
- **Links:** [GitHub](https://github.com/spring-ai-community/awesome-spring-ai)

### Spring AI in Action (Manning)

- **Badge:** Book
- **Description:** Book by Craig Walls — comprehensive guide to building AI apps with Spring
- **Links:** [Book](https://www.manning.com/books/spring-ai-in-action)

### Understanding LangChain4j

- **Badge:** Book
- **Description:** Book by Antonio Goncalves — explore the fundamentals of AI, learn the history and evolution of AI models, and understand the core concepts of LangChain4j
- **Links:** [Book](https://www.amazon.com/Understanding-LangChain4j-2nd-agoncal-fascicles-ebook/dp/B0FDQVSLXK)

### AI Agents with Java (O'Reilly)

- **Badge:** Book
- **Description:** Early-release O'Reilly book by Java Champions Alex Soto Bueno, Markus Eisele, and Mario Fusco — building long-running, stateful agents on the JVM with zero-trust security, RAG, and multi-agent coordination using Quarkus, LangChain4j, and LangGraph4j
- **Links:** [Book](https://www.oreilly.com/library/view/ai-agents-with/0642572245856/)

### Applied AI for Enterprise Java Development (O'Reilly)

- **Badge:** Book
- **Description:** Book by Alex Soto Bueno, Markus Eisele, and Natale Vinto — prompt engineering, RAG, guardrails, fault tolerance, and enterprise AI architecture using Quarkus, LangChain4j, and vector stores
- **Links:** [Book](https://www.oreilly.com/library/view/applied-ai-for/9781098174491/)

### Production LangChain4j — Inside.java

- **Badge:** Resource
- **Description:** Advanced RAG, agentic workflows, and production tips from Devoxx Belgium
- **Links:** [Article](https://inside.java/2026/02/01/devoxxbelgium-production-langchain4j/)

### Google ADK Java Codelab

- **Badge:** Resource
- **Description:** Hands-on: build AI agents in Java with Google's ADK
- **Links:** [Codelab](https://codelabs.developers.google.com/adk-java-getting-started)

### Devoxx YouTube

- **Badge:** Videos
- **Description:** Thousands of conference talks on Java, AI, cloud, and architecture
- **Links:** [YouTube](https://www.youtube.com/@DevoxxForever)

### Coffee + Software

- **Badge:** Videos
- **Description:** Spring ecosystem, AI integration, and Java community
- **Links:** [YouTube](https://youtube.com/@coffeesoftware)

### Foojay Podcast: Java AI Revolution

- **Badge:** Resource
- **Description:** Agents, MCP, graph databases — developers navigate the AI revolution
- **Links:** [Podcast](https://foojay.io/today/foojay-podcast-86/)

### Building Java AI Agents with Spring AI (AWS Workshop)

- **Badge:** Workshop
- **Description:** Hands-on AWS workshop for building intelligent AI agents with Spring AI and AWS services, including deployment to EKS
- **Links:** [Workshop](https://catalog.workshops.aws/java-spring-ai-agents/en-US)

## AI & Java on Serverless Office Hours
- **Badge:** Livestream
- **Description:** James Ward and Julian Wood explore building AI-powered Java apps — MCP integration, agent architectures with AgentCore, GraalVM optimization for AI workloads, and secure auth patterns for AI services on serverless
- **Links:** https://www.youtube.com/watch?v=my2bQtHBUeY

### Java for an AI World — JavaOne 2026 Opening Keynote

- **Badge:** Videos
- **Description:** Opening keynote of JavaOne 2026, featuring Rod Johnson, Josh Long, and engineering leads from Oracle, Microsoft, NVIDIA, JetBrains, and Uber on Java's AI direction, including the GitHub Copilot SDK for Java
- **Links:** https://www.youtube.com/watch?v=3fLCOqpIfI0

### Bootiful Spring AI — Josh Long & James Ward @ Spring I/O 2026

- **Badge:** Videos
- **Description:** Talk from Spring I/O 2026 in Barcelona demystifying AI integration with Spring Boot — agentic patterns, Spring AI, and MCP integration
- **Links:** https://www.youtube.com/watch?v=nHnKReitDXc

### Java and AI in 2026 and Beyond — James Ward Interview

- **Badge:** Videos
- **Description:** 68-minute interview with James Ward on the Code With Ease channel, recorded at GIDS Bangalore — the Java AI landscape from Spring AI, LangChain4j, Koog, and Embabel to MCP, agent memory, RAG vs tools vs skills, and production deployment with AWS AgentCore
- **Links:** https://www.youtube.com/watch?v=-TWXNYRE0Q8

### Liberty LangChain4j Workshop

- **Badge:** Workshop
- **Description:** Hands-on, self-paced Open Liberty workshop that progresses from a simple chatbot to agentic systems using LangChain4j — prompt engineering, streaming, RAG, tool calling, MCP, guardrails/observability, and multi-agent supervisor patterns
- **Links:** [Workshop](https://openliberty.github.io/liberty-workshop-langchain4j/) · [Blog](https://openliberty.io/blog/2026/07/10/liberty-langchain4j-workshop.html)

### ScarfBench

- **Badge:** Resource
- **Description:** IBM Research's open benchmark for evaluating AI agents on enterprise Java framework migration — 102 applications and 204 tasks (~1,331 tests) covering Jakarta EE, Quarkus, and Spring, with a public leaderboard.
- **Links:** [GitHub](https://github.com/scarfbench/benchmark) · [Announcement](https://www.ibm.com/new/announcements/scarfbench-a-public-benchmark-for-java-framework-migration)

---

## Footer

"AI4JVM — Curating the Java AI ecosystem. Contributions welcome on [GitHub](https://github.com/jamesward/ai4jvm)."
