# linux-setup-ansible
An ansible project to configure stuff on a system. Everything is set to be idempotent, and rerunning the playbook will also update all tools.

## Install & setup
To use Ansible, a couple of tools are required:

* git (to clone this repo)
* pipx (to install ansible)
* ansible (to configure the system)

1) Oneliner to install all above:
```bash
sudo apt update && sudo apt install -y git pipx && pipx install ansible --include-deps && pipx ensurepath && exec $SHELL
```

2) Clone this repository:
```bash
git clone https://github.com/fjfinch/linux-setup-ansible.git
```

Go to the `ansible/` folder:

3) Pull required roles:
```bash
ansible-galaxy collection install -r requirements.yml
```

4) Execute the playbook: 
```bash
ansible-playbook main.yml -K
```
