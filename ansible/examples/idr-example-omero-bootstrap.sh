#!/bin/sh

set -e

# gcc needed for ansible dependencies
yum install -y git python-virtualenv gcc
virtualenv --system-site-packages /opt/ansible
/opt/ansible/bin/pip install ansible

git clone --single-branch -b omego https://github.com/manics/infrastructure.git
ANSIBLE_VARS='{"omero_release": "5.2.2" }'
#ANSIBLE_VARS='{"omero_release": "OMERO-build", "omero_omego_additional_args": "-qq --ci alternative-ci.openmicroscopy.org:8080"}'

ANSIBLE_ROLES_PATH=./infrastructure/ansible/roles /opt/ansible/bin/ansible-playbook \
    ./infrastructure/ansible/examples/idr-example-omero.yml --extra-vars "$ANSIBLE_VARS"
