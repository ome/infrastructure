#!/usr/bin/bash

set -eux
shopt -s extglob

# ansible-galaxy returns 0 even if an error occurs so parse output
ansible-galaxy install -r requirements.yml 2>&1 | tee galaxy-1.log
grep ERROR galaxy-1.log && exit 2
ansible-galaxy install -r requirements-compat.yml 2>&1 | tee galaxy-2.log
grep ERROR galaxy-2.log && exit 2

for f in !(requirements*).yml *-playbooks/*.yml; do
    # ansible-lint $f
    ansible-playbook -i example-hosts --syntax-check $f
done
