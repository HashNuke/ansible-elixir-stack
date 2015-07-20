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


## Optional config

##### mix_env

The `MIX_ENV` to use when running the app. Default is `prod`.

##### git_ref

Git ref of the project to deploy. This can be a branch (*recommended*) or tag or commit you want to deploy. Defaults to `master` branch.

* Default: `master`
* Examples: `74e09b4fe3fca`, `stable`, `v3.4.1`


##### deploy_type

> **NOTE:** Read the documentation on [Hot code-reloading](hot-code-reloading.md) for whys & hows of this variable.

By default, on each deploy your app will be restarted. Setting it to `upgrade` will do a hot code-reload of your app instead.

* Default: `restart`
* Possible values: `restart`, `upgrade`

You can switch between restarts and upgrades anytime.

##### secret_key_base_length

Length of the secret key base. Can be set to any integer.

* Default: `64`

##### deployer

The name of the user to create to run all your projects. Default is `deployer`.

##### projects_dir

The dir where all your projects will be stored. This is relative to the $HOME of the deployer user.

* Default: `projects`

##### setup_postgres

If you app doesn't require postgres, set this option to `False`.

* Default: `True`
* Possible values: `True`, `False`


### Frontend build configuration

##### build_frontend

If the app does not require building frontends, set this this to `False`.

* Default: `True`
* Possible values: `True`, `False`

#### frontend_dir

The directory where the `package.json` file resides. For a Phoenix app by default is the root of the project dir. This path is relative to the project's root dir. So if your frontend dir is within a dir called `client` in your project, then the value of this variable should be `client`.

* Default: `""` (an empty string)


##### frontend_build_command

The command to use to build the frontend.

* Default: `$(npm bin)/brunch build --production`
* Examples: `$(npm bin)/ember build`, `npm run build`

> `$(npm bin)` returns the path to bin dir in the `node_modules` of the project. Since no npm packages are installed globally, you'll have to use locally installed binaries.


#### post_frontend_build

Command that should be run after the frontend build has completed. This is run in the project directory's root.

* Default: `mix phoenix.digest`

### Swap file configuration

##### create_swap_file

Creates a swap if this is set to `True`.

* Default: `True`
* Possible values: `True`, `False`

##### swap_size

If `create_swap_file` is set to `True`, this option can be used to specify the size of the swap to create. by default the size is 2gb. If you aren't sure leave this unchanged.

* Default: `2097K`
* Possible values: calculated as `1024 * 1024 * n`. So for 4gb that would be 4194304, which can be specified as `4194K`


### NPM configuration

##### npm_config_jobs

Set this to more than `1` if npm should be allowed to be run in parallel. For 512mb RAM servers, it's better to set this to `1`.

* Default: `1`
* Example values: `2`, `5`

##### npm_config_install_production

If set to `True`, npm dependencies will be installed with `npm install --production`. Else it is just `npm install`.

* Default: `False`
* Possible values: `True`, `False`


### Monitoring email alerts

##### enable_mail_alerts

Will send mail alerts when stuff goes down. If this is enabled, SMTP configuration needs to be provided.

* Default: `False`
* Possible values: `True`, `False`

You could use GMail, [MailGun](http://mailgun.com), [Amazon SES](http://aws.amazon.com/ses/), [SendGrid](https://sendgrid.com) or anything else. Most providers have a free quota that should be sufficient for your hobby apps.

##### app_alert_emails

List of email addresses to alert if the app goes down. No emails are sent by default.

* Default: `[]`
* Example values:
    * `["foo@example.com"]`
    * `["foo@example.com", "bar@example.com"]`


##### nginx_alert_emails

List of email addresses to alert if nginx goes down. No emails are sent by default.

* Default: `[]`
* Example values:
    * `["foo@example.com"]`
    * `["foo@example.com", "bar@example.com"]`

> NOTE: `nginx_alert_emails` is common for the entire server. So if you set it in one app, maintain the same values in all your apps. Please create an issue if you can think of a better solution.


##### smtp_host

Set this to your SMTP host.

Example values: `smtp.gmail.com`, `smtp.mailgun.org`

##### smtp_port

Set this to your host's SMTP port. For most servers, the default would work.

* Default: `587`

##### smtp_user

Email address you want to send mails from.

* Example values: `foo@example.com`, `foo@bar.example.com`

##### smtp_password

Password for the SMTP user account.

##### smtp_use_tls

Does your SMTP host use TLS? As a reference, set this to `True` for GMail & `False` for [MailGun](http://mailgun.com).

* Default: `False`
* Possible values: `True`, `False`
