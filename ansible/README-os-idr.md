Openstack IDR Playbooks
=======================

To setup the IDR create a group_vars file if necessary in `inventory/group_vars/`, e.g. `inventory/group_vars/os-idr.yml`
This should match the value of the `idr_environment` variable (default `os-idr`), and can be used to support multiple deployment environments with different variables.

Decide on your openstack dynamic inventory.
If you are using a single floating IP use `inventory/openstack-private.py`.
using private internal IPs and a gateway server on the Openstack cloud.
If you are using floating IPs for all instances you can optionally use `inventory/openstack.py` instead.

Select your playbook, for instance `os-idr-uod.yml` for the Dundee cloud.

For example (using the default `os-idr` host-group and variables):

    ansible-playbook -i inventory/openstack-private.py os-idr-uod.yml
        -e vm_key_name="KEY_NAME" -e vm_prefix=PREFIX

Or using a custom group called `os-idrstaging` with additional variable overrides:

    ansible-playbook -i inventory/openstack-private.py os-idr-uod.yml
        -e vm_key_name="KEY_NAME" -e vm_prefix=PREFIX
        -e @vars/test-overrides.yml -e idr_environment=os-idrstaging


Component playbooks
-------------------

TODO:
