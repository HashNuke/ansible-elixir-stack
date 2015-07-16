# prod.secret.exs

This file is auto-generated when the app is setup. The following template is used.

```elixir
use Mix.Config

config {{app_name}}, {{ app_endpoint }},
  secret_key_base: "{{ secret_key_base }}"


config {{ app_name }}, {{ app_repo_module }},
  adapter: Ecto.Adapters.Postgres,
  username: "{{ database_user }}",
  password: "{{ database_password }}",
  database: "{{ database_name }}",
  size: 20
```

**You can over-ride this default** template by placing your own template as `playbooks/templates/prod.secret.exs.j2` in your project. This file uses [Jinga2](http://jinja.pocoo.org) templating engine that Ansible uses. You can quickly identify that variables are surrounded with `{{` and `}}`. That all you need to know to work with this file.

The following variables are made available (calculated approximately):

* `app_name` - This is the OTP app name that you set in `playbooks/vars/main.yml`
* `app_endpoint_module` - The endpoint module to serve
* `secret_key_base` - A secret key base is generated on the server
* `app_repo_module` - The repo module the app uses
* `database_user` - Database user (same as the deployer variable)
* `database_password` - auto-generated and stored on the server
* `database_name` - calculated based on the mix_env. Format is `<app_name>_<mix_env>`
