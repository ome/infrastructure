## OME Ansible repository

# Installation

- Create a virtualenv
      virtualenv venvs/ansible
- Install ansible:
      venvs/ansible/bin/pip install ansible
- Optionally add `venvs/ansible/bin/` to path
- Clone this repository and change into the this directory
      git clone https://github.com/openmicroscopy/infrastructure.git
- Copy the private group and host variable files into
  - `host_vars/`
  - `group_vars/`
  - Copy the private host inventory files into this directory

# Examples

In the following examples replace example-hosts with the private host inventory file

Dry-run `provision.yml` for all hosts listed in `provision.yml`:
- `-u` Login as this user
- `-b` use `sudo`
- `--ask-become-pass` prompt for sudo password
- `-C` Dry-run mode
- `-v` Verbose (repeat to increase verbosity)

Note this may fail since some tasks are dependent on others being completed:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass -C -v provision.yml

Run `provision.yml`:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass provision.yml

Run `provision.yml` for all subset of the hosts or groups listed in `provision.yml`:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass provision.yml --limit $HOST_OR_GROUP_NAME

List the hosts that would be targeted by a command, don't do anything else:

    ansible-playbook -i example-hosts provision.yml --list-hosts
