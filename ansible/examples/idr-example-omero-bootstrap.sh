#!/bin/sh

# gcc needed for ansible dependencies
yum install -y git python-virtualenv gcc
virtualenv --system-site-packages /opt/ansible
/opt/ansible/bin/pip install ansible

git clone --single-branch -b omego https://github.com/manics/infrastructure.git

ANSIBLE_ROLES_PATH=./infrastructure/ansible/roles /opt/ansible/bin/ansible-playbook \
    ./infrastructure/ansible/examples/idr-example-omero.yml
