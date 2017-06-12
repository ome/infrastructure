import testinfra.utils.ansible_runner
import json

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    '.molecule/ansible_inventory').get_hosts('all')

OMERO = '/opt/omero/web/OMERO.web/bin/omero'
