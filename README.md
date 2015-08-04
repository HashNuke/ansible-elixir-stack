# ansible-elixir-stack

Tool to deploy [Elixir](http://elixir-lang.org/) & [Phoenix](http://www.phoenixframework.org) apps to servers.

**Docs**: [[Configuration](docs/configuration.md)], [[Hot code-reloading](docs/hot-code-reloading.md)], [[prod.secret.exs file](docs/prod-secret-file.md)], [[Logs](docs/logs.md)]

## Features

* **1-command setup & deploys**
* Ships with Postgres support
* Automatically creates a [`prod.secret.exs`](docs/prod-secret-file.md) file
* Deploy multiple hobby apps on a $5 DigitalOcean server
* Custom domains
* Hot code-reloading using [exrm](https://github.com/bitwalker/exrm)
* Monitoring & automatic restarts using `monit`
* Organized as an Ansible role, BUT requires no knowledge of Ansible

> To deploy to Heroku, use the [Heroku Elixir buildpack](https://github.com/HashNuke/heroku-buildpack-elixir) instead.

## Install

```sh
$ pip install ansible
$ ansible-galaxy install HashNuke.elixir-stack

# assuming your SSH key is called `id_rsa`
# run this everytime you start your computer
$ ssh-add ~/.ssh/id_rsa
```

> If the above commands fail, try with `sudo`.
> For Mac OS X, Ansible is also available on homebrew.

## Setup your project

1.) Add [exrm](https://github.com/bitwalker/exrm) as your project's dependency in mix.exs

```elixir
defp deps do
  [{:exrm, "~> 0.18.1"}]
end
```

2.) In your project dir, run following command:

```sh
$ curl -L http://git.io/ansible-elixir-stack.sh | bash
```

**FOLLOW INSTRUCTIONS OF ABOVE COMMAND**

> Checkout the [documentation on configuration options](docs/configuration.md)

## Deploy your project

Assuming you have root SSH access to the server

##### To deploy the first time

```sh
$ ansible-playbook playbooks/setup.yml
```

##### To update your project

```sh
$ ansible-playbook playbooks/deploy.yml
```

> By default the application is restarted on each deploy. [Read how to enable hot code-reloading](docs/hot-code-reloading.md).

## FAQ

* **Is this only meant for small $5 servers?**  
Should fit servers of any size. In that case you could also increase the swap and npm

* **How to have different set of servers for staging and production?**  
Use the `inventory` file as a template and maintain different inventory files for staging and production. Let's say your staging inventory file is called `staging.inventory`, then you could do `ansible-playbook setup.yml -i staging.inventory` (and similar for deploy). Notice the `-i` switch.
*B/w if you are going this way, you probably should learn Ansible or hire someone who knows it*


## Misc

* [ansible-galaxy guide](http://docs.ansible.com/galaxy.html#installing-roles)
