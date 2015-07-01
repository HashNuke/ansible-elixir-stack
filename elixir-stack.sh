#!/usr/bin/env bash

current_directory=$(basename pwd)
git_repo_url=$(git config --get remote.origin.url)
mkdir -p deployment/vars

cat <<EOF
---
hosts: app-servers

roles:
  - {role: "elixir-stack", action: "setup"}
EOF > deployment/setup.yml


cat <<EOF
---
hosts: app-servers

roles:
  - {role: "elixir-stack", action: "deploy"}
EOF > deployment/deploy.yml


cat <<EOF
[app-servers]
1.2.3.4
4.5.6.7

# Delete the above IP addresses and add your server's IP addresses
EOF > deployment/inventory


cat <<EOF
[defaults]
inventory=inventory
EOF > deployment/ansible.cfg

cat <<EOF
---
project_name: $current_directory
project_repo: "$git_repo_url"
EOF > deployment/vars/main.yml


if [ -z ./.tool-versions ]; then
  cat <<EOF
erlang 18.0
elixir 1.0.5
nodejs 0.12.5
EOF
  echo "TODO Edit .tool-versions file with appropriate versions of Erlang, Elixir & Node.js required for project"
fi

echo "TODO Add server IP address to deployment/inventory file"
echo "TODO Edit project name & git url in deployment/vars/main.yml"
