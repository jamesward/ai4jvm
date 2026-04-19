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
- **"What is MCP and how does it work with Java?"** — "The Model Context Protocol (MCP) is an open standard that lets AI assistants interact with external tools and data sources. The official MCP Java SDK, maintained by the Spring AI team, provides both client and server implementations with sync/async support and multiple transports (STDIO, SSE, Streamable HTTP). Helidon MCP and several frameworks also offer MCP support."
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

- https://aws.amazon.com/blogs/machine-learning/spring-ai-sdk-for-amazon-bedrock-agentcore-is-now-generally-available/
- https://developers.googleblog.com/announcing-adk-for-java-100-building-the-future-of-ai-agents-in-java/
- https://blog.jetbrains.com/idea/2026/03/ai-assisted-java-application-development-with-agent-skills/
- https://spring.io/blog/2026/03/26/spring-ai-2-0-0-M4-and-1-1-4-and-1-0-5-available
- https://blog.jetbrains.com/kotlin/2026/03/introducing-tracy-the-ai-observability-library-for-kotlin/
- https://www.tmdevlab.com/mcp-server-performance-benchmark.html
- https://thenewstack.io/2026-java-ai-apps/
- https://medium.com/embabel/agent-memory-is-not-a-greenfield-problem-ground-it-in-your-existing-data-9272cabe1561
- https://inside.java/2026/02/01/devoxxbelgium-production-langchain4j/

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
- **Description:** Agentic AI platform built on Akka's actor model for distributed, resilient systems. Declarative Effects API for building goal-directed agents with durable memory, multi-agent orchestration, and automatic scaling. MCP and A2A protocol support, pluggable LLM providers, runtime prompt updates, and agents auto-exposed as HTTP, gRPC, or MCP endpoints. Java and Scala SDKs.
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
- **Description:** The official Java SDK for Model Context Protocol servers and clients. Maintained by the Spring AI team. Sync/async, STDIO/SSE/Streamable HTTP transports, OAuth support via Spring integration.
- **Links:** [Docs](https://modelcontextprotocol.io/sdk/java/mcp-overview) · [GitHub](https://github.com/modelcontextprotocol/java-sdk)

### Anthropic Java SDK
- **Badge:** SDK
- **Description:** Official Java SDK for the Claude Messages API. Streaming, retries, structured outputs, extended thinking, code execution, and files API. Build Java apps powered by Claude.
- **Links:** [GitHub](https://github.com/anthropics/anthropic-sdk-java)

### GitHub Copilot SDK for Java
- **Badge:** SDK
- **Description:** Official Java SDK for embedding the GitHub Copilot agentic engine directly into Java applications. Uses the same agentic harness that powers the Copilot CLI — exposes planning, tool calling, file editing, and MCP integration via a simple Java API. Currently in technical preview.
- **Links:** [Docs](https://github.github.com/copilot-sdk-java/) · [GitHub](https://github.com/github/copilot-sdk-java)

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
- **Description:** The official Java SDK for [Agent-2-Agent Protocol (A2A)](https://a2a-protocol.org) servers and clients. Reference implementation based on Quarkus.
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

---

## Java with Code Assistants

Technologies that supercharge Java development when paired with AI code assistants — from MCP servers that give agents live Javadoc access, to reusable skill packages and IDE integrations.

**Section focus:** Prioritize tools that bridge the gap between AI assistants and the Java ecosystem — MCP servers, skill registries, IDE plugins, and context providers — over general-purpose AI tools.

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

### TensorFlow Java
- **Badge:** Training
- **Description:** Java bindings for TensorFlow, maintained by the TensorFlow JVM SIG. Train and deploy TF models entirely in Java. Available as an optional Tribuo integration. Suitable for teams that want to stay within the JVM ecosystem while using TensorFlow's model formats.
- **Links:** [Docs](https://www.tensorflow.org/jvm) · [GitHub](https://github.com/tensorflow/java)

---

## People to Follow

Key voices at the intersection of Java and AI.
Notes:
- Alphabetical by last name
- Indicate if someone is a Java Champion using a badge on its own line (below the name, above the role). Don't repeat "Java Champion" in the role text. Lookup: https://github.com/aalmiray/java-champions/blob/main/java-champions.yml
- Add profile photos if found.
- Add Twitter, GitHub, LinkedIn, Bluesky, YouTube, if available.

### Bruno Borges

- **Badge:** Person
- **Java Champion**
- **Initials:** BB
- **Photo:** https://avatars.githubusercontent.com/u/129743?v=4
- **Role:** Principal Program Manager — Microsoft Java Engineering Group
- **Links:** [@brunoborges](https://twitter.com/brunoborges) · [Bluesky](https://bsky.app/profile/brunoborges.bsky.social) · [GitHub](https://github.com/brunoborges) · [LinkedIn](https://ca.linkedin.com/in/brunocborges) · [Blog](https://blog.brunoborges.info/)

### Eric Deandrea

- **Badge:** Person
- **Java Champion**
- **Initials:** ED
- **Photo:** https://avatars.githubusercontent.com/u/363447?v=4
- **Role:** [Docling Java](https://docling-project.github.io/docling-java/current) project lead, contributor to LangChain4j, Sr. Principal Software Engineer at IBM
- **Links:** [Bluesky](https://bsky.app/profile/ericdeandrea.dev) · [@edeandrea](https://x.com/edeandrea) · [GitHub](https://github.com/edeandrea) · [LinkedIn](https://www.linkedin.com/in/edeandrea/)

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

### Rod Johnson

- **Badge:** Person
- **Java Champion**
- **Initials:** RJ
- **Photo:** https://avatars.githubusercontent.com/u/1916583?v=4
- **Role:** Creator of Spring Framework, CEO of Embabel
- **Links:** [@springrod](https://twitter.com/springrod) · [GitHub](https://github.com/johnsonr) · [LinkedIn](https://www.linkedin.com/in/johnsonroda/) · [Blog](https://medium.com/@springrod)

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

### Simon Martinelli

- **Badge:** Person
- **Initials:** MP
- **Photo:** https://avatars.githubusercontent.com/u/593352?v=4
- **Role:** Creator of AI Unfied Process and jOOQ MCP Server
- **Links:** [@simas_ch](https://twitter.com/simas_ch) · [GitHub](https://github.com/simach) · [LinkedIn](https://www.linkedin.com/in/simonmartinelli/)

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

### Oleg Šelajev

- **Badge:** Person
- **Java Champion**
- **Initials:** OŠ
- **Photo:** https://avatars.githubusercontent.com/u/426039?v=4
- **Role:** Developer Relations Lead for AI — Docker
- **Links:** [@shelajev](https://twitter.com/shelajev) · [GitHub](https://github.com/shelajev) · [LinkedIn](https://www.linkedin.com/in/shelajev/)

### Bartosz Sorrentino

- **Badge:** Person
- **Initials:** BS
- **Photo:** https://avatars.githubusercontent.com/u/301596?v=4
- **Role:** LangGraph4j creator, Principal Software Architect
- **Links:** [@bsorrentinoJ](https://twitter.com/bsorrentinoJ) · [GitHub](https://github.com/bsorrentino) · [LinkedIn](https://www.linkedin.com/in/bartolomeosorrentino/)

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

---

## FAQ

Frequently asked questions about AI development on the JVM. Rendered as a Q&A list. Include matching `FAQPage` structured data in the page `<head>`.

### What is the best Java framework for building AI agents?
The most popular choices are Spring AI and LangChain4j. Spring AI is ideal if you're already in the Spring ecosystem, offering portable abstractions across 20+ model providers. LangChain4j provides a standalone library with three levels of abstraction, from low-level prompts to high-level AI Services. Other options include Google ADK for Java, Embabel, and Akka Agents — each with different strengths for specific use cases.

### Can Java run LLMs locally?
Yes. Projects like Jlama and GPULlama3.java run Llama, Mistral, and other models directly on the JVM. Jlama uses Java's Vector API for SIMD-accelerated inference on CPU, while GPULlama3.java leverages TornadoVM for GPU acceleration. For production deployments, ONNX Runtime Java supports hardware-accelerated inference across CUDA, DirectML, and CoreML.

### What is MCP and how does it work with Java?
The Model Context Protocol (MCP) is an open standard that lets AI assistants interact with external tools and data sources. The official MCP Java SDK, maintained by the Spring AI team, provides both client and server implementations with sync/async support and multiple transports (STDIO, SSE, Streamable HTTP). Helidon MCP and several frameworks also offer MCP support.

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

---

## Footer

"AI4JVM — Curating the Java AI ecosystem. Contributions welcome on [GitHub](https://github.com/jamesward/ai4jvm)."
