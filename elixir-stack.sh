#!/usr/bin/env sh

current_directory=$(basename `pwd`)
git_repo_url=$(git config --get remote.origin.url)
mkdir -p playbooks/vars playbooks/templates

cat > playbooks/setup.yml <<EOF
---
hosts: app-servers

roles:
  - {role: "elixir-stack", action: "setup"}
EOF


cat > playbooks/deploy.yml <<EOF
---
hosts: app-servers

roles:
  - {role: "elixir-stack", action: "deploy"}
EOF


cat > playbooks/inventory <<EOF
[app-servers]
1.2.3.4
4.5.6.7

# Delete the above IP addresses and add your server's IP addresses
EOF


cat > ansible.cfg <<EOF
[defaults]
inventory=inventory
EOF

cat > playbooks/vars/main.yml <<EOF
---
project_name: $current_directory
project_repo: "$git_repo_url"
app_port: 3001
EOF


cat > playbooks/templates/config.secret.exs.j2 <<EOF
---

EOF


# Check if SERVER=1 when starting release.
# This way we can compile the release with auto-start server
# But for all other purposes, can run mix tasks

grep -nri "{:phoenix" mix.exs
if [ $? = 0 ]; then
  cat >> config/config.exs <<EOF
# This line was automatically added by ansible-elixir-stack setup script
if System.get_env("SERVER") do
  config :phoenix, :serve_endpoints, true
end
EOF
fi


echo '*-*-*'
echo 'Oolaa ~! your project has been setup for deployment'
echo '*-*-*'
echo


# Create .tool-versions file if not present

if [ -z ./.tool-versions ]; then
  cat > .tool-versions <<EOF
erlang 18.0
elixir 1.0.5
nodejs 0.12.5
EOF
  echo "TODO Edit .tool-versions file with appropriate versions of Erlang, Elixir & Node.js required for project"
fi

echo "TODO Add server IP address to playbooks/inventory file"
echo "TODO Edit project name & git url in playbooks/vars/main.yml"
