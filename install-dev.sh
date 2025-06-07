#!/bin/bash

# Interactive runner for Ansible dev-setup playbook
# Provides options for sudo (-K) and verbosity levels

echo "🔐 Running Ansible Dev Setup with privilege escalation..."
echo "📦 You will be prompted to choose which components to install."

# Ask for verbosity level
read -p "Do you want verbose mode? (none / -v / -vv / -vvv): " verbosity

# Default to no verbosity if not provided
verbosity=${verbosity:-}

# Run the playbook with -K (prompt for become password) and selected verbosity
ansible-playbook dev-setup.yml -K $verbosity
