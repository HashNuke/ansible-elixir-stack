# ansible-elixir-stack

Tool to deploy your Elixir apps to servers

> Organized as an Ansible role, but requires no knowledge of Ansible

## Features

* **1-command setup & deploys**
* Deploy multiple hobby apps on a $5 DigitalOcean server
* Supports [Phoenix framework](http://phoenixframework.org) out of the box
* Monitoring using `monit`
* Automatic restarts if app crashes
* TODO Log rotation

## Install (once on your computer)

##### 1.) Install Ansible

```shell
$ pip install ansible
```

> If the above command fails, try with a `sudo` prefix.
> For Mac OS X, Ansible is also available on homebrew.

##### 2.) Install the `HashNuke.elixir-stack` Ansible role

```shell
$ ansible-galaxy install HashNuke.elixir-stack
```

*Detailed guide on using the `ansible-galaxy` command is available on the [Ansible website](http://docs.ansible.com/galaxy.html#installing-roles)*

## Setup (once for every project)

In your project's directory, run following command:

```shell
$ curl http://git.io/elixir-stack.sh | bash
```

Follow instructions it outputs.

## Deploying your project

##### To deploy the first time

```sh-session
$ cd deployment
$ ansible-playbook setup.yml
```

##### To updating your project

```shell
$ cd deployment
$ ansible-playbook deploy.yml
```

## Other configuration

You can add more variables to `deployment/vars/main.yml`. Refer to the table below for available variables and their default values.


project_version
frontend_build (default True)
frontend_dir
frontend_build_command
deployer (default deployer)
elixir_framework (automatically detected)
create_swap (default True)
swap_space (default 2gb)
npm_jobs_config (default 1)
monitoring_emails
setup_postgres (default: True)

## FAQ

* **Is this role meant only for small $5 servers?**  
Should fit servers of any size. In that case you could also increase the swap and npm jobs config for more freedom.

* **This role goes against modularity of Ansible roles**  
I needed a quick & easy way to setup stuff for hobby apps that don't fit on Heroku. This one solves my problem.

* **How to have different set of servers for staging and production?**  
Use the `inventory` file as a template and maintain different inventory files for staging and production. Let's say your staging inventory file is called `staging.inventory`, then you could do `ansible-playbook setup.yml -i staging.inventory` (and similar for deploy). Notice the `-i` switch. *B/w if you are going this way, you probably should learn Ansible or hire someone who knows it*
