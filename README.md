# linux-setup-ansible
An ansible project to configure stuff on a system. Everything is set to be idempotent, and rerunning the playbook will also update all tools.

## Install & setup
To install Ansible, use the oneliner on the README of this [repo](https://github.com/fjfinch/ansible-template).

Next, clone this repository:
```bash
git clone https://github.com/fjfinch/linux-setup-ansible.git
```

Go to the `ansible/` folder and run the following command to pull required roles:
```bash
ansible-galaxy collection install -r requirements.yml
```

And use the following to execute the playbook: 
```bash
ansible-playbook main.yml -K
```
