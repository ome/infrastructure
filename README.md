# OME Infrastructure

Tools, scripts and other systems infrastructure used to support the work of the OME http://www.openmicroscopy.org/

Eventually this will be used for setting up production servers including OMERO instances.
If you are interested in this work please be aware it is a relatively new initiative and still under development, so please [contact us](http://www.openmicroscopy.org/site/community) if you require more information.


[![Build Status](https://travis-ci.org/openmicroscopy/infrastructure.png)](http://travis-ci.org/openmicroscopy/infrastructure)

## OME Ansible repository


This playbook uses Ansible 2.0 features. See
[the Ansible documentation](http://docs.ansible.com/ansible/intro_installation.html)
for full installation instructions.

### Installation

- Create a virtual environment and install the Ansible requirements (including
  `shade` for using with OpenStack):

        virtualenv ~/venvs/ansible
        ~/venvs/ansible/bin/pip install -r requirements.txt

- Clone this repository:

        git clone https://github.com/openmicroscopy/infrastructure.git

- Execute the following commands from the `ansible` subdirectory of the
  infrastructure repository.

- Clone the repository containing the inventory, host and group vars files.
  Ansible will automatically look for `host_vars` and `group_vars`
  directories in the parent directory of the inventory file. This should be
  located at `../../ansible/inventory` such that `-i ../../ansible/inventory`
  would be correct.

### Examples

In the following examples replace example-hosts with the private host inventory file

Dry-run `ci-provision.yml` for all hosts listed in `ci-provision.yml`:
- `-u` Login as this user
- `--ask-become-pass` prompt for sudo password
- `-C` Dry-run mode
- `-v` Verbose (repeat to increase verbosity)

Note this may fail since some tasks are dependent on others being completed:

    ansible-playbook -u $USERNAME --ask-become-pass -C -v ci-provision.yml

Run `provision.yml`:

    ansible-playbook -u $USERNAME --ask-become-pass ci-provision.yml

Run `provision.yml` for all subset of the hosts or groups listed in `provision.yml`:

    ansible-playbook -u $USERNAME --ask-become-pass ci-provision.yml --limit $HOST_OR_GROUP_NAME

List the hosts that would be targeted by a command, don't do anything else:

    ansible-playbook ci-provision.yml --list-hosts


Playbooks which do not alter hardware can often be tested in Docker instead of a full VM, for example by using the [omero-ssh](https://github.com/manics/ome-docker/blob/omero-ssh/omero-ssh/Dockerfile) image:

    docker run -d omero-ssh
    # Optional:
    ssh-copy-id omero@172.17.1.1
    # Pass -K if sudo requires a password, and -k if ssh keys aren't setup
    ansible-playbook -i etc/test-hosts -u omero ci-deployment.yml -bv
