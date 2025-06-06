#!/bin/bash
set -e

echo "🚀 Installing Ansible..."
sudo apt update
sudo apt install -y ansible curl git unzip python3-pip

echo "🛠️ Running the Dev Setup Playbook..."
ansible-playbook dev-setup.yml -K
