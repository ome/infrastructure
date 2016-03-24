#!/bin/sh

set -e

# gcc needed for ansible dependencies
yum install -q -y git python-virtualenv gcc 2>&1
virtualenv -q --system-site-packages /opt/ansible 2>&1
/opt/ansible/bin/pip -q install ansible 2>&1

git clone -q --single-branch -b omego https://github.com/manics/infrastructure.git 2>&1
ANSIBLE_VARS='{"omero_release": "5.2.2" }'
#ANSIBLE_VARS='{"omero_release": "OMERO-build", "omero_omego_additional_args": "--ci alternative-ci.openmicroscopy.org:8080"}'

export ANSIBLE_ROLES_PATH=./infrastructure/ansible/roles
/opt/ansible/bin/ansible-playbook ./infrastructure/openstack/examples/idr-example-omero.yml \
    --extra-vars "$ANSIBLE_VARS" 2>&1

exit 0
