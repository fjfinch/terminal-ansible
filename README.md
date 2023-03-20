# ansible-linux
An ansible project to setup some stuff on a system. Everything is set to be idempotent, and rerunning the playbook will also update all tools.

## Install
To use this repository, a couple of tools are required:

* git (to clone this repo & to pull other repos)
* pipx (to install ansible)
* ansible (to configure the system)

Oneliner to install all above:

```bash
sudo apt update && sudo apt install -y git pipx && pipx install ansible --include-deps && pipx ensurepath && exec $SHELL
```

Next, clone this repository:

```bash
git clone https://github.com/fjfinch/ansible-linux.git
```

## Run
Go to the `ansible/` folder and run:

```bash
ansible-playbook main.yml -K
```
