#!/usr/bin/env sh

app_name=$(grep -m 1 -oh 'app: :[[:alnum:]_]*' mix.exs | sed 's/app:\ ://')
git_repo_url=$(git config --get remote.origin.url)
mkdir -p playbooks/vars playbooks/templates

cat > playbooks/setup.yml <<EOF
---
- hosts: app-servers
  remote_user: root
  vars_files:
    - vars/main.yml

  roles:
    - {role: "HashNuke.elixir-stack", action: "setup"}
EOF


cat > playbooks/deploy.yml <<EOF
---
- hosts: app-servers
  remote_user: root
  vars_files:
    - vars/main.yml

  roles:
    - {role: "HashNuke.elixir-stack", action: "deploy"}
EOF


cat > playbooks/migrate.yml <<EOF
---
- hosts: app-servers
  remote_user: root
  vars_files:
    - vars/main.yml

  roles:
    - {role: "HashNuke.elixir-stack", action: "migrate"}
EOF


cat > playbooks/remove-app.yml <<EOF
---
- hosts: app-servers
  remote_user: root
  vars_files:
    - vars/main.yml

  roles:
    - {role: "HashNuke.elixir-stack", action: "remove-app"}
EOF


cat > inventory <<EOF
[app-servers]
1.2.3.4
4.5.6.7

# Delete the above IP addresses and add your server's IP addresses
EOF


cat > ansible.cfg <<EOF
[defaults]
inventory=inventory

[ssh_connection]
ssh_args="-o ForwardAgent=yes"
EOF

cat > playbooks/vars/main.yml <<EOF
---
app_name: $app_name
repo_url: "$git_repo_url"
app_port: 3001
EOF


# Check if SERVER=1 when starting release.
# This way we can compile the release with auto-start server
# But for all other purposes, can run mix tasks

grep -m 1 -nriq "{:phoenix" mix.exs
if [ $? = 0 ]; then
  cat >> config/config.exs <<EOF

# This line was automatically added by ansible-elixir-stack setup script
if System.get_env("SERVER") do
  config :phoenix, :serve_endpoints, true
end
EOF
fi

echo
echo '*-*-*'
echo 'Oolaa ~! your project has been setup for deployment'
echo '*-*-*'
echo


# Create .tool-versions file if not present

if [ ! -f ./.tool-versions ]; then
  cat > .tool-versions <<EOF
erlang 18.0
elixir 1.0.5
nodejs 0.12.5
EOF
  echo "TODO Edit .tool-versions file with appropriate versions of Erlang, Elixir & Node.js required for project"
fi

echo "TODO Add server IP address to inventory file"
echo "TODO Edit app name, app port & repo url in playbooks/vars/main.yml"
