Openstack IDR Playbooks
=======================

To setup the IDR create a group_vars file if necessary in `inventory/group_vars/`, e.g. `inventory/group_vars/idr.yml`
This should match the value of the `idr_environment` variable

Decide on your openstack dynamic inventory.
If you are using a single floating IP use `inventory/openstack-private.py`.
using private internal IPs and a gateway server on the Openstack cloud.
If you are using floating IPs for all instances you can optionally use `inventory/openstack.py` instead.

TODO: Select your playbook, either `os-idr-uod.yml` for the Dundee cloud or

For example:

    ansible-playbook -e vm_key_name="KEY_NAME" -e vm_prefix=PREFIX
        -i inventory/openstack-private.py os-idr-uod.yml


Component playbooks
-------------------

TODO:
