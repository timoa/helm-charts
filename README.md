# Helm Charts for AI / LLMOps / MLOps

Collection of useful Helm Charts (at least for me 😜) to help deploy open-source projects related to AI, LLMOps or MLOps.

> **_NOTE:_** I will publish the Helm charts in `beta` as soon as I have created the CI/CD workflow with versioning and package on the GitHub Registry.

## Status

| Status | Name | Description |
|--------|------|-------------|
| 🚀 | `stable` | Ready for production |
| 🛠 | `beta` | Ready for testing |
| 🚧 | `not-ready` | Under development |
| 📋 | `planned` | Plan to be developed |
| 🚫 |`deprecated` | Not recommended |

## Charts

### AI Apps

| Status | Name | Category | Description | | |
|--------|------|----------|-------------|---------|--------|
| 🛠 | Ollama | LLMs Manager | Expose LLMs as API | [Website][ollama-website] | [GitHub][ollama-github] |
| 🛠 | Open WebUI | AI WebUI | User-friendly AI Interface (Supports Ollama, OpenAI API, ...) | [Website][openwebui-website] | [GitHub][openwebui-github] |
| 🛠 | Firecrawl | Crawler | Turn entire websites into LLM-ready markdown or structured data. Scrape, crawl and extract with a single API. | [Website][firecrawl-website] | [GitHub][firecrawl-github] |
| 🛠 | Danswer | RAG | Danswer is the open source AI assistant connected to your company's docs, apps, and people. | [Website][danswer-website] | [GitHub][danswer-github] |
| 🛠 | ComfyUI + Flux | Image | Deploy ComfyUI and Flux1.1Pro |  | [GitHub][comfyui-flux-github] |
| 🚧 | Perplexica | Search | Open-source alternative to Perplexity | | [GitHub][perplexica-github] |
| 📋 | Agenta | Prompt Manager | Agenta provides integrated tools for prompt engineering, versioning, evaluation, and observability, all in one place. | [Website][agenta-website] | [GitHub][agenta-github] |
| 📋 | Promptfoo | Security | Test your prompts, agents, and RAGs. Red teaming, pentesting, and vulnerability scanning for LLMs. Compare performance of GPT, Claude, Gemini, Llama, and more. | [Website][promptfoo-website] | [GitHub][promptfoo-github] |
| 📋 | OpenPerplex | Search | Open-source alternative to Perplexity | [Website][openperplex-website] | [GitHub][openperplex-github] |
| 📋 | Crawl4AI | Crawler | Open-source LLM Friendly Web Crawler & Scrapper | [Website][crawl4ai-website] | [GitHub][crawl4ai-github] |
| 📋 | Typebot | Chatbot | Typebot is a powerful chatbot builder that you can self-host. | [Website][typebot-website] | [GitHub][typebot-github] |

### AI Agents tools

| Status | Name | Category | Description | Website | GitHub |
|--------|------|----------|-------------|---------|--------|
| 📋 | Ntfy | Notifications | Send push notifications to your phone or desktop using PUT/POST. | [Website][ntfy-website] | [GitHub][ntfy-github] |
| 📋 | HeyForm | Forms | Simplify data collection, engage users, and achieve meaningful results. | [Website][heyform-website] | [GitHub][heyform-github] |

[ollama-website]: https://ollama.com
[ollama-github]: https://github.com/ollama/ollama
[openwebui-website]: https://openwebui.com
[openwebui-github]: https://github.com/open-webui/open-webui
[firecrawl-website]: https://firecrawl.dev
[firecrawl-github]: https://github.com/mendableai/firecrawl
[danswer-website]: https://danswer.ai/
[danswer-github]: https://github.com/danswer-ai/danswer
[comfyui-flux-github]: https://github.com/frefrik/comfyui-flux
[perplexica-github]: https://github.com/ItzCrazyKns/Perplexica
[openperplex-website]: https://openperplex.com/
[openperplex-github]: https://github.com/YassKhazzan/openperplex_backend_os
[agenta-website]: https://agenta.ai/
[agenta-github]: https://github.com/agenta-ai/agenta
[promptfoo-website]: https://promptfoo.dev/
[promptfoo-github]: https://github.com/promptfoo/promptfoo
[crawl4ai-website]: https://crawl4ai.com
[crawl4ai-github]: https://github.com/unclecode/crawl4ai
[typebot-website]: https://typebot.io/
[typebot-github]: https://github.com/baptisteArno/typebot.io
[ntfy-website]: https://ntfy.sh/
[ntfy-github]: https://github.com/binwiederhier/ntfy
[heyform-website]: https://heyform.net/
[heyform-github]: https://github.com/heyform/heyform
