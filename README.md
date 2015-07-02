# ansible-elixir-stack

Tool to deploy [Elixir](http://elixir-lang.org/) & [Phoenix](http://www.phoenixframework.org) apps to servers.

> Organized as an Ansible role, BUT requires no knowledge of Ansible

## Features

* **1-command setup & deploys**
* Deploy multiple hobby apps on a $5 DigitalOcean server
* Monitoring & automatic restarts using `monit`
* Log rotation

## Install

```shell
$ pip install ansible
$ ansible-galaxy install HashNuke.elixir-stack
```

> If the above commands fail, try with `sudo`.
> For Mac OS X, Ansible is also available on homebrew.

## Setup your project

1.) Add exrm as your project's dependency

2.) In your project dir, run following command:

```shell
$ curl http://git.io/elixir-stack.sh | bash
```

**FOLLOW INSTRUCTIONS OF ABOVE COMMAND**

## Deploy your project

Assuming you have/do the following:
* SSH root access to the server
* Update project's version in `mix.exs` everytime you deploy (OR [read on how to avoid this](docs/automate-project-version.md))

##### To deploy the first time

```sh-session
$ ansible-playbook playbooks/setup.yml
```

##### To update your project

```shell
$ ansible-playbook playbooks/deploy.yml
```

## FAQ

* **Is this role meant only for small $5 servers?**  
Should fit servers of any size. In that case you could also increase the swap and npm jobs config for more freedom.

* **This role goes against modularity of Ansible roles**  
I needed a quick & easy way to setup stuff for hobby apps that don't fit on Heroku. This one solves my problem.

* **How to have different set of servers for staging and production?**  
Use the `inventory` file as a template and maintain different inventory files for staging and production. Let's say your staging inventory file is called `staging.inventory`, then you could do `ansible-playbook setup.yml -i staging.inventory` (and similar for deploy). Notice the `-i` switch. *B/w if you are going this way, you probably should learn Ansible or hire someone who knows it*


## Misc

* [ansible-galaxy guide](http://docs.ansible.com/galaxy.html#installing-roles)
