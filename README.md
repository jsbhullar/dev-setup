# 🛠️ Ubuntu Dev Machine Setup

This repository automates the installation of a full modern development stack on a freshly installed Ubuntu Desktop.

## ✅ Features

- **Python (via pyenv)** with uv, pipx
- **Node.js (via nvm)**, Go, Rust
- **Docker** + **Portainer** GUI
- **PostgreSQL** in Docker
- **Ollama** for running local LLMs
- **Open WebUI** (on port `3002`) for chat with Ollama
- **Dokploy** (PaaS platform, on port `3000`)

## 🚀 How to Use

```bash
git clone https://github.com/YOUR_USERNAME/dev-setup.git
cd dev-setup
./install-dev.sh
```

## 🌐 Services

| Service       | URL                     | Notes                           |
|---------------|--------------------------|----------------------------------|
| Portainer     | https://localhost:9443   | Manage Docker containers         |
| Dokploy       | http://localhost:3000    | PaaS for deploying apps          |
| Open WebUI    | http://localhost:3002    | Chat with local LLMs via Ollama |
| PostgreSQL    | localhost:5432           | devuser / devpass / devdb        |

## 📦 After Installation

- Use `ollama run llama2` to run models
- Use `dokploy` UI or CLI to deploy your apps
- Use `docker ps` and `portainer` for container overview

## 🔁 Update Services

```bash
docker pull ghcr.io/open-webui/open-webui
docker restart open-webui

docker pull dokploy/dokploy:latest
docker restart dokploy
```
