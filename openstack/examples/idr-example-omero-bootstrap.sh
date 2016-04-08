#!/bin/sh

set -e

# gcc needed for ansible dependencies
yum install -q -y git python-virtualenv gcc 2>&1

if [ ! -d /opt/ansible ];
then
  virtualenv -q --system-site-packages /opt/ansible 2>&1
  /opt/ansible/bin/pip -q install ansible 2>&1
fi

cd /opt

[ -d /opt/infrastructure ] || git clone -q --single-branch -b omego https://github.com/manics/infrastructure.git /opt/infrastructure 2>&1

# Custom variable overrides (YAML, can be empty)
cat << EOF > /opt/infrastructure/localhost-extravars.yml
omero_release: "5.2.2"
#omero_release: OMERO-build
#omero_omego_additional_args: "--ci alternative-ci.openmicroscopy.org:8080"
EOF

export ANSIBLE_ROLES_PATH=/opt/infrastructure/ansible/roles
/opt/ansible/bin/ansible-playbook /opt/infrastructure/openstack/examples/idr-example-omero.yml \
    --extra-vars "omero_selinux_setup=False @/opt/infrastructure/localhost-extravars.yml" 2>&1


exit 0
