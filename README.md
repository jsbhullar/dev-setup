# Ubuntu Developer Workstation Setup (Ansible Playbook)

This repository contains an Ansible playbook (`dev-setup.yml`) designed to automate the setup of a powerful developer workstation based on Ubuntu Desktop. It aims to install and configure a range of essential development tools and services.

## Purpose

The `dev-setup.yml` playbook automates the installation and configuration of various software components required for a modern development workflow. By running this playbook, you can quickly set up a consistent environment including language version managers, containerization tools, databases, and IDEs.

## Prerequisites

*   A machine running Ubuntu Desktop (or a compatible Debian-based distribution).
*   `git` installed on the target machine to clone this repository.
*   `ansible` installed on the target machine. You can typically install it using `sudo apt update && sudo apt install ansible`.
*   Sudo privileges for the user running the playbook, as some tasks require root access (handled by `become: yes` in the playbook).
*   An active internet connection to download packages, tools, and container images.

## How to Run the Setup

This repository includes a simple bash script, `install-dev.sh`, to facilitate running the Ansible playbook with the necessary options.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/jsbhullar/dev-setup.git
    cd dev-setup
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x install-dev.sh
    ```

3.  **Run the installation script:**
    ```bash
    ./install-dev.sh
    ```

The script will:
*   Print introductory messages.
*   Prompt you if you want to enable verbose output for the Ansible run (you can enter `-v`, `-vv`, `-vvv`, or just press Enter for no verbosity).
*   Execute the `ansible-playbook dev-setup.yml -K [verbosity]` command. The `-K` flag will prompt you for your user's password for sudo (privilege escalation) when the playbook requires it.
*   The Ansible playbook will then run, prompting you interactively for each optional component you wish to install (Go, Rust, Ollama, etc.). Respond with `yes` or `no`.

## What the Playbook Does

The `dev-setup.yml` playbook performs the following actions:

*   **Base System Setup:**
    *   Updates the system's package list (`apt update`).
    *   Installs essential build tools and common packages (`build-essential`, `curl`, `git`, `unzip`, `zip`, `software-properties-common`, `apt-transport-https`, `ca-certificates`, `gnupg`, and various development libraries like `libssl-dev`, `zlib1g-dev`, `libreadline-dev`, `libffi-dev`, etc., along with `python3-pip`).

*   **Python Stack (via pyenv):**
    *   Installs `pyenv` by cloning its repository into `~/.pyenv`.
    *   Adds `pyenv` initialization lines to the user's `~/.bashrc` file to configure the shell environment.
    *   Installs Python version `3.12.3` using `pyenv`.
    *   Sets Python `3.12.3` as the global default Python version for the user using `pyenv`.
    *   Installs `pipx` using the newly installed Python version.
    *   Installs `uv` (a fast Python package installer and resolver) using `pipx`.

*   **Node.js (via nvm):**
    *   Installs `nvm` (Node Version Manager) using its official install script into `~/.nvm`.
    *   Adds `nvm` initialization lines to the user's `~/.bashrc` file.
    *   Installs the latest LTS (Long Term Support) version of Node.js using `nvm`.

*   **Rust (Optional):**
    *   *If you choose to install Rust:* Downloads and runs the `rustup.rs` script to install Rust and the Cargo package manager.
    *   Adds Cargo's binary directory (`~/.cargo/bin`) to the user's `PATH` in `~/.bashrc`.

*   **Go (Optional):**
    *   *If you choose to install Go:* Downloads the Go `1.22.3` binary release for Linux AMD64.
    *   Extracts the Go archive to `/usr/local`.
    *   Adds the Go binary directory (`/usr/local/go/bin`) to the user's `PATH` in `~/.bashrc`.

*   **Docker (Optional):**
    *   *If you choose to install Docker:* Downloads and runs the official `get-docker.sh` convenience script.
    *   Adds the current user to the `docker` group, allowing non-root execution of Docker commands (requires logging out and back in or restarting the system to take effect).
    *   Ensures the Docker systemd service is enabled and started.

*   **Portainer (Optional, Docker GUI):**
    *   *If you choose to install Portainer and Docker:* Creates a Docker volume named `portainer_data`.
    *   Runs the `portainer/portainer-ce:latest` Docker container, configured to start automatically, expose ports `8000` (edge agent) and `9443` (web UI), and use the `portainer_data` volume. Access the UI at `https://localhost:9443`.

*   **Ollama (Optional, Local LLM Runner):**
    *   *If you choose to install Ollama:* Downloads and runs the official `ollama.com/install.sh` script to install Ollama, a tool for running large language models locally.

*   **Open WebUI (Optional, Ollama Frontend):**
    *   *If you choose to install Open WebUI and Ollama:* Creates a directory `~/.open-webui` for data persistence.
    *   Runs the `ghcr.io/open-webui/open-webui` Docker container, configured to restart unless stopped, map host port `3002` to container port `3000`, mount the data directory, and set the `OLLAMA_BASE_URL` to connect to the locally installed Ollama instance. Access the UI at `http://localhost:3002`.

*   **PostgreSQL (in Docker):**
    *   Runs a `postgres:16` Docker container named `dev-postgres`, configured to restart unless stopped.
    *   Maps host port `5432` to the container's port `5432`.
    *   Sets environment variables for the default user (`devuser`), password (`devpass`), and database (`devdb`). Connect to this instance at `localhost:5432`.

*   **Visual Studio Code (Optional):**
    *   *If you choose to install VS Code:* Downloads and installs the latest stable `code_*.deb` package from Microsoft. This typically also adds the VS Code repository for future updates via `apt`. Launch using `code` in the terminal or via the application menu.

*   **pgAdmin 4 Desktop (Optional, PostgreSQL GUI):**
    *   *If you choose to install pgAdmin:* Downloads the pgAdmin public key and adds it to the system's keyrings.
    *   Adds the official pgAdmin 4 APT repository to your system's software sources.
    *   Updates the APT cache and installs the `pgadmin4-desktop` package. Launch via the application menu. Connect to the `dev-postgres` container at `localhost:5432` using the defined credentials.

## Port Map Summary (for Docker services)

| Service         | Access URL/Port         | Notes                                  |
| :-------------- | :---------------------- | :------------------------------------- |
| **Portainer**   | `https://localhost:9443`  | Docker GUI                             |
| **Open WebUI**  | `http://localhost:3002` | Frontend for local Ollama instance     |
| **PostgreSQL**  | `localhost:5432`        | Development database instance (`devdb`)|

Note: The Dokploy service mentioned in previous README versions is **not** included in the current `dev-setup.yml` playbook provided.

## Contributing

Feel free to fork this repository and modify the `dev-setup.yml` playbook to fit your specific development needs. If you identify improvements to the playbook structure or find issues, consider opening a pull request.

## License

MIT License

Copyright (c) [2025] [Meharsoft Technologies Pvt.Ltd.]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
