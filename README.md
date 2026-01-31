# Gemini-Vibe-Stack ♊️

production-ready, AI-native skeleton repository centered around Google Gemini's ecosystem.
Integrates Vibe (Kanban) + Gemini Automation + Code-Server (VS Code).

## Stack Overview
- **vibe-server**: Node.js 20-slim container with pre-installed Gemini SDKs.
- **code-server**: Browser-based IDE for development.
- **Gemini Integration**: Built-in support for `@google/generative-ai`.
- **Zero-Config**: Single script setup for permissions and secrets.

## Getting Started

### 1. Prerequisities
- Docker & Docker Compose
- Google Cloud API Key (Gemini)

### 2. Quick Setup
Run the initialization script to set up permissions and environment variables:
\`\`\`bash
./scripts/init-setup.sh
\`\`\`

### 3. Configuration
Edit the generated \`.env\` file and add your GEMINI_API_KEY:
\`\`\`bash
GEMINI_API_KEY=your_key_here
\`\`\`

### 4. code-server Configuration
The \`.env\` file also contains a `CODE_SERVER_PASSWORD` variable (default: `gemini`). Change this to secure your IDE.

### 5. Launch
Start the stack:
\`\`\`bash
docker-compose up -d
\`\`\`

- **Vibe Server**: http://localhost:3000 (once you deploy your app here)
- **Code Server**: http://localhost:8443 (Password: see `.env`)

## Features

### 🧠 massive Context Window (Gemini 1.5 Pro)
Use the included script to aggregate your entire project into a single prompt for heavy refactoring tasks.

`
./scripts/gen-context.sh
`

This generates \`gemini_context.md\`. Upload this file to Gemini Advanced or AI Studio to give the model full visibility of your codebase.

### 🔄 Service Mesh & Deployment
The \`vibe-server\` container mounts the \`/repos\` directory. You can use it to run CI/CD-like tasks or automated tests across your microservices.

### 🔐 Secrets Management
Secrets in \`.env\` are securely passed to containers. Agents running in \`vibe-server\` can access keys via environment variables or the \`/secrets\` mounted volume (if configured).

## Project Structure

```
├── repos/           # Workspace for your apps/microservices
├── secrets/         # Secure storage (gitignored)
├── agents/          # Gemini agent configurations
├── scripts/         # Automation scripts
├── docker-compose.yml
└── .env             # Environment variables
```