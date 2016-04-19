#!/bin/sh

set -eu

# EPEL now has Ansible 2.x
# TODO: Temporarily force cache update since this is a very recent update
yum clean -q all 2>&1
yum install -q -y epel-release 2>&1
yum install -q -y ansible git 2>&1

cd /opt

[ -d /opt/infrastructure ] || git clone -q --single-branch -b omego https://github.com/manics/infrastructure.git /opt/infrastructure 2>&1

# Custom variable overrides (YAML, can be empty)
# Use this instead of command line args to avoid complicated quoting issues
VARSFILE=/opt/infrastructure/localhost-extravars.yml
cat << EOF > $VARSFILE
#omero_release: "5.2.2"
omero_release: OMERO-DEV-merge-build
#omero_omego_additional_args: "--ci alternative-ci.openmicroscopy.org:8080"
EOF

if [ \! -f /usr/sbin/getenforce -o /usr/sbin/getenforce = Disabled  ]; then
    echo "omero_selinux_setup: False" >> $VARSFILE
fi

export ANSIBLE_ROLES_PATH=/opt/infrastructure/ansible/roles
ansible-playbook /opt/infrastructure/openstack/examples/idr-example-omero.yml \
    --extra-vars "@/opt/infrastructure/localhost-extravars.yml" 2>&1

exit 0
