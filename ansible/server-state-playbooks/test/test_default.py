import testinfra.utils.ansible_runner
import json

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    '.molecule/ansible_inventory').get_hosts('all')

OMERO = '/opt/omero/web/OMERO.web/bin/omero'


def test_omero_web_public(Command):
    out = Command.check_output(
        'curl http://localhost/webclient/api/containers/')
    r = json.loads(out)
    assert r['screens'] == []
    assert r['plates'] == []
    assert r['projects'] == []
    assert r['datasets'] == []
