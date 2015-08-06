# Hot code-reloading

By default, apps are restarted when new versions are deployed. This is to make it easy for people to deploy apps quickly with quick setup.

### To enable

* Set the `deploy_type` variable to `upgrade` in your project's `playbooks/vars/main.yml` file
* Everytime you deploy, update the app's version in the project's `mix.exs`


### Automatic versioning using git

For hot code-reloading, the app's version needs to be updated in `mix.exs` for every deploy. That can get repeatitive, since hobby projects are updated & deployed frequently. We've got a workaround for that. We'll use automatic versioning based on git commit SHAs. Technical details are explained in [this blog post](TODO).

* Change the following in `mix.exs`

```elixir
def project do
  [app: :hello_phoenix,
   version: "1.4.1",
   elixir: "~> 1.0",
   ...
```

to look like the following

```elixir
def project do
  {result, _exit_code} = System.cmd("git", ["rev-parse", "HEAD"])

  # We'll truncate the commit SHA to 7 chars. Feel free to change
  git_sha = String.slice(result, 0, 7)

  [app: :hello_phoenix,
   version: "1.4.1-#{git_sha}",
   elixir: "~> 1.0",
   ...
```

That just changes the `version` to use the git commit SHA.
