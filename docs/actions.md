# Actions

Below are a list of stuff you can do with the provided playbooks. All commands are meant to be run in your project's root directory.


#### Setup server

```
$ ansible-playbook playbooks/setup.yml
```

The app is also deployed for the first time. So when this command completes, you should have your app running.

#### Deploy

```
$ ansible-playbook playbooks/deploy.yml
```

#### Migrate database

```
$ ansible-playbook playbooks/migrate.yml
```

The ecto.migrate task is run as the deployer user, with the MIX_ENV specified in your configuration in playbooks/vars/main.yml.

#### Remove app from the server

```
$ ansible-playbook playbooks/remove-app.yml
```

#### Run command in the project's directory on the server

```
$ ansible-playbook playbooks/run-cmd.yml -e "cmd='foo bar'"
```

The command is run as the deployer user, with the MIX_ENV specified in your configuration in playbooks/vars/main.yml.
