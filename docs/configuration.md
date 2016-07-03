# Configuration options

Variables are set in the `playbooks/vars/main.yml` file in your project. A few variables are mandatory and others have convenient defaults. Refer to the list of variables below for details.

## Required config

##### app_name

Name of your OTP app. This is the name of your project in `mix.exs` (the value of the `app` key in the `project` function).

* Example values: `foo`, `bar`

Let's say your app's mix.exs looks like this:

```elixir
defmodule Firebrick.Mixfile do
  use Mix.Project

  def project do
    [app: :firebrick,
     version: "0.0.2",
     ...
```

`firebrick` is your app name here.

> Do not use the hostname of your server as the app's name. Monit will have conflicts and error out.

##### repo_url

Git url of your project

* Example values:
    * `https://example.com/foo/bar.git`
    * `foo@example.com:bar.git`

##### app_port

Must be set to an integer. Port must not be used by any apps already on the same server.

> Suggestion: Start somewhere at 3001 and keep incrementing it for every app you deploy. Easier to keep track.

##### domains

The domains/subdomains to use for your project. By default your project is accessible from the IP address. Using projects without domains isn't recommended since Nginx will only serve the first project for an IP address. If you intend to host multiple projects on a server, use domain or subdomain names.

* Default: `[]`
* Example values:
    * `["example.com"]`
    * `["example.com", "foo.example.com", "bar.example.com"]`


## Other options

There is a tonne of other options. All of them along with explanation can be found in the [defaults/vars.yml](https://github.com/HashNuke/ansible-elixir-stack/blob/master/defaults/vars.yml) file
