# 🛠️ Ubuntu Developer Workstation Setup

This repository provides a **fully automated setup** script using **Ansible** to transform a fresh Ubuntu Desktop system into a powerful, AI-ready development machine.

---

## 📦 What's Included and Why

### 🔁 Base System Setup
- Updates the system and installs essential build tools (`build-essential`, `curl`, `git`, `unzip`, etc.)

---

### 🐍 Python Stack (via pyenv)
- Enables installation of **multiple Python versions**
- Global default set to **3.12.3**
- Includes `pipx` and `uv` for modern, isolated Python tooling

> 📌 Update Python version:
```bash
pyenv install 3.13.0
pyenv global 3.13.0
````

---

### ⚙️ Node.js (via nvm)

* Version-managed Node environment
* Installs the latest **LTS release** of Node.js

> 📌 Update Node version:

```bash
nvm install --lts
nvm use --lts
```

---

### 🚀 Rust and Go

* **Rust** installed via `rustup`
* **Go** (v1.22.3) installed via official binary

> 📌 Update:

```bash
rustup update
```

> For Go, update manually via latest `.tar.gz` download.

---

### 🐳 Docker + Portainer

* Docker installed via official script
* Adds user to `docker` group for non-root usage
* **Portainer CE** runs on `https://localhost:9443` for container management

> 📌 Update Portainer:

```bash
docker pull portainer/portainer-ce
docker stop portainer && docker rm portainer
docker run -d -p 8000:8000 -p 9443:9443 \
  --name=portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```

---

### 🧠 Ollama (Local LLM Runner)

* Runs large language models locally (like LLaMA2, Mistral, etc.)

> 📌 Use it like:

```bash
ollama run llama2
```

> 📌 Update:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

---

### 🌐 Open WebUI (on port `3002`)

* Web-based chat interface for Ollama
* Chat history is persisted via a volume in `~/.open-webui`

> 📌 Update:

```bash
docker pull ghcr.io/open-webui/open-webui
docker restart open-webui
```

---

### 🚀 Dokploy (on port `3000`)

* Self-hosted PaaS platform to deploy apps using Docker Compose
* Installed via official script
* UI available at `http://localhost:3000`

> 📌 Update:

```bash
docker pull dokploy/dokploy:latest
docker restart dokploy
```

---

### 🗃 PostgreSQL (in Docker)

* Development PostgreSQL instance
* Credentials:

  * `user`: `devuser`
  * `password`: `devpass`
  * `db`: `devdb`

> 📌 Update:

```bash
docker pull postgres:16
docker restart dev-postgres
```

---

### 🧑‍💻 Visual Studio Code (VS Code)

* Installed from official Microsoft repository
* Lightweight, extensible IDE with marketplace

> 📌 Launch:

```bash
code
```

> 📌 Update:
> Handled via system package manager:

```bash
sudo apt update && sudo apt upgrade code
```

---

### 🗂 pgAdmin 4 (PostgreSQL GUI)

* GUI tool to manage PostgreSQL databases locally
* Installed as a native GTK desktop app

> 📌 Launch: Search **pgAdmin 4** from application menu
> 📌 Connect to DB:

* Host: `localhost`
* Port: `5432`
* Username: `devuser`
* Password: `devpass`

---

## 🔧 Installation Instructions

1. Clone this repository:

```bash
git clone https://github.com/YOUR_USERNAME/dev-setup.git
cd dev-setup
```

2. Run the setup script:

```bash
./install-dev.sh
```

> 🛡️ It will prompt for your sudo password when needed.

---

## 🌍 Port Map Summary

| Service       | URL/Access                                       |
| ------------- | ------------------------------------------------ |
| Portainer     | [https://localhost:9443](https://localhost:9443) |
| Dokploy       | [http://localhost:3000](http://localhost:3000)   |
| Open WebUI    | [http://localhost:3002](http://localhost:3002)   |
| PostgreSQL DB | `localhost:5432`                                 |
| VS Code       | `code` in terminal or app menu                   |
| pgAdmin 4     | Application menu > pgAdmin 4                     |

---

## 🤝 Contributing

Pull requests to add other languages, SDKs, GUI tools (e.g., Deno, Java, RedisInsight), or LLM enhancements are welcome!