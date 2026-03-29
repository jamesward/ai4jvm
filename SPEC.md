# AI4JVM Site Specification

AI4JVM is a curated guide to the Java AI ecosystem — a single-page website covering agent frameworks, inference engines, code assistants, key people, and learning resources.

## Guidelines

- Validate accuracy with recent web information

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
- Subtitle: "Your curated guide to the Java AI ecosystem — agent frameworks, inference engines, code assistants, key people, and the best learning resources."

---

## News

Latest headlines about the Java AI ecosystem. Each item has a link and brief description.
Note: Order by date, newest first. Don't show news older than 3 months

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

### LangChain4j CDI
- **Badge:** Framework
- **Description:** CDI extension for LangChain4j (part of the LangChain4j project) that brings AI services to Jakarta EE and MicroProfile applications. Inject AI services as CDI beans with `@RegisterAIService`, configure via MicroProfile Config, and add resilience with Fault Tolerance. Supports Quarkus, Helidon, WildFly, Payara, GlassFish, Liberty, and any CDI-capable runtime.
- **Links:** [GitHub](https://github.com/langchain4j/langchain4j-cdi)

### LangGraph4j
- **Badge:** Framework
- **Description:** Build stateful, multi-agent applications with cyclical graphs. Inspired by Python's LangGraph, works with both LangChain4j and Spring AI. Persistent checkpoints, deep agent architectures, and a Studio web UI.
- **Links:** [Docs](https://langgraph4j.github.io/langgraph4j/) · [GitHub](https://github.com/langgraph4j/langgraph4j)

### Koog (JetBrains)
- **Badge:** Framework
- **Description:** Kotlin-native agent framework from JetBrains. Type-safe DSL, multiplatform (JVM, JS, WasmJS, Android, iOS), A2A protocol support, fault tolerance with persistence, and multi-LLM support.
- **Links:** [Website](https://www.jetbrains.com/koog/) · [GitHub](https://github.com/JetBrains/koog) · [Docs](https://docs.koog.ai/)

### Semantic Kernel (Java)
- **Badge:** Framework
- **Description:** Microsoft's AI orchestration SDK with first-class Java support. Provides prompt chaining, planning, memory, and agent framework abstractions with deep Azure integration.
- **Links:** [GitHub](https://github.com/microsoft/semantic-kernel-java)

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

---

## Inference & Training

Run models, train classifiers, and do ML inference directly on the JVM — no Python required.

### Jlama
- **Badge:** Inference
- **Description:** Modern LLM inference engine written in pure Java. Runs Llama, Gemma, Mistral, and more locally on CPU. Uses Java's Vector API (Project Panama) for SIMD-accelerated matrix math. Supports SafeTensors format, quantized models, and distributed inference.
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

### Markus Eisele

- **Badge:** Person
- **Java Champion**
- **Initials:** ME
- **Photo:** https://avatars.githubusercontent.com/u/1358554?v=4
- **Role:** Developer Advocate — IBM Research, JavaLand founder
- **Links:** [@myfear](https://twitter.com/myfear) · [Bluesky](https://bsky.app/profile/myfear.com) · [GitHub](https://github.com/myfear) · [LinkedIn](https://www.linkedin.com/in/markuseisele/) · [Blog](https://blog.eisele.net/)

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

### Mario Fusco

- **Badge:** Person
- **Java Champion**
- **Initials:** MF
- **Photo:** https://avatars.githubusercontent.com/u/372781?v=4
- **Role:** LangChain4j core team, Sr. Principal Software Engineer at IBM
- **Links:** [@mariofusco](https://x.com/mariofusco) · [GitHub](https://github.com/mariofusco) · [LinkedIn](https://www.linkedin.com/in/mario-fusco-3467213/)

### Eric Deandrea

- **Badge:** Person
- **Java Champion**
- **Initials:** ED
- **Photo:** https://avatars.githubusercontent.com/u/363447?v=4
- **Role:** [Docling Java](https://docling-project.github.io/docling-java/current) project lead, contributor to LangChain4j, Sr. Principal Software Engineer at IBM
- **Links:** [Bluesky](https://bsky.app/profile/ericdeandrea.dev) · [@edeandrea](https://x.com/edeandrea) · [GitHub](https://github.com/edeandrea) · [LinkedIn](https://www.linkedin.com/in/edeandrea/)

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
