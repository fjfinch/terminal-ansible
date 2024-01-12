# terminal-ansible
Ansible playbook to configure a terminal (terminator + zsh + custom .zshrc).

## Install & setup
To use this repo, a couple of tools are required:

* git (to clone the repo)
* pipx (to install ansible)
* ansible (to configure the system)

1 - Oneliner to install all above:
```bash
sudo apt update && sudo apt install -y git pipx && pipx install ansible --include-deps && . ~/.profile
```

2 - Clone this repository:
```bash
git clone https://github.com/fjfinch/terminal-ansible.git
```

3 - Within `ansible/` - pull the required roles:
```bash
ansible-galaxy collection install -r requirements.yml
```

4 - Within `ansible/` - execute the playbook:
```bash
ansible-playbook main.yml -K
```
