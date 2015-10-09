OME Ansible repository
======================

This playbook uses Ansible 2.0 features (which is still in development), do not use `pip install ansible`.
See http://docs.ansible.com/ansible/intro_installation.html for full installation instructions.

Installation
------------

- Create a virtualenv:

        virtualenv venvs/ansible

- Clone ansible and submodules:

        git clone git://github.com/ansible/ansible.git --recursive

- Install dependencies listed in `setup.py`:

        venvs/ansible/bin/pip install paramiko jinja2 PyYAML pycrypto six

- Clone this repository:

        git clone https://github.com/openmicroscopy/infrastructure.git

- Clone the repository containing the inventory, host and group vars files.
  Ansible will automatically look for `host_vars` and `group_vars` directories in the parent directory of the inventory file.


Running the development ansible
-------------------------------

- Activate the virtualenv:

        source venvs/ansible/bin/activate

- Activate the Ansible development environment:

        source ansible/hacking/env-setup -q

All ansible tools should now be in your path.

Alternatively adjust the paths in this script as necessary:

```shell
#!/bin/sh
source ~/venvs/ansible/bin/activate
source ~/github/ansible/hacking/env-setup -q
exec "$(basename $0)" "$@"
```

And copy/symlink it into a directory on your `PATH` as `ansible`, `ansible-playbook`, etc (the script should automatically run the ansible command corresponding to it's file name).

As another alternative you can probably install ansible into your virtualenv (untested):

        venvs/ansible/bin/python setup.py install --help

Examples
--------

In the following examples replace example-hosts with the private host
inventory file

Dry-run `ci-provision.yml` for all hosts listed in `ci-provision.yml`:
- `-u` Login as this user
- `-b` use `sudo`
- `--ask-become-pass` prompt for sudo password
- `-C` Dry-run mode
- `-v` Verbose (repeat to increase verbosity)

Note this may fail since some tasks are dependent on others being completed:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass -C -v ci-provision.yml

Run `provision.yml`:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass ci-provision.yml

Run `provision.yml` for all subset of the hosts or groups listed in `provision.yml`:

    ansible-playbook -i example-hosts -u $USERNAME -b --ask-become-pass ci-provision.yml --limit $HOST_OR_GROUP_NAME

List the hosts that would be targeted by a command, don't do anything else:

    ansible-playbook -i example-hosts ci-provision.yml --list-hosts


Playbooks which do not alter hardware can often be tested in Docker instead of a full VM, for example by using the [omero-ssh](https://github.com/manics/ome-docker/blob/omero-ssh/omero-ssh/Dockerfile) image:

    docker run -d omero-ssh
    # Optional:
    ssh-copy-id omero@172.17.1.1
    # Pass -K if sudo requires a password, and -k if ssh keys aren't setup
    ansible-playbook -i etc/test-hosts -u omero ci-deployment.yml -bv
