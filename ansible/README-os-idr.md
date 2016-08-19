Openstack and IDR Playbooks
===========================


OMERO OpenStack VM Deployment
-----------------------------

This repository contains example files for provisioning an OpenStack VM from scratch with OMERO using Ansible, as used by the Image data Repository.
Most of these scripts should also work on other platforms, providing the VM is brought up by some other method.
The guest must be running CentOS 7.


Guide for the Impatient
-----------------------

Setup your OpenStack environment variables, and run:

    ansible-playbook -i inventory -e omero_vm_name=FOO -e omero_vm_key_name=YOUR_KEY os-idr-uod.yml


`os-idr-playbooks/os-omero.yml`
-------------------------------

This is the Ansible playbook that will be run to setup OMERO.
You can also run it manually to install OMERO on localhost.


`os-idr-playbooks/os-create.yml`
--------------------------------

This playbook will connect to OpenStack and spin up a VM.
The Ansible modules in this playbook require the `shade` Python module.

Before running the playbook you must [setup your OpenStack environment variables](http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html).
You can override variables at the command line, for example (note double quoting is necessary if spaces are present):

    ansible-playbook os-idr-playbooks/os-create.yml -e omero_vm_name=FOO \
        -e omero_vm_key_name=YOURKEY -e "omero_vm_flavour='m2.xxlarge'"

If this step fails it could be due to an incorrect variable, the Ansible `os_server` module usually gives an uninformative "Error in creating instance" message.
If the VM was created the floating IP of the VM will be printed out.

To delete the VM and related security group:

    ansible-playbook os-idr-playbooks/os-delete.yml -e omero_vm_name=FOO

If another instance is using the OMERO security group, the task will fail but can be safely ignored.


Inventory
---------

This directory takes advantage of an
[Ansible dynamic inventory script for OpenStack (`openstack.py`)](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-openstack-external-inventory-script)
instead of having to manage an inventory file when using Ansible to push out changes.
For example:

    ansible-playbook -i inventory -l os-image-centos os-idr-playbooks/os-omero.yml -vv

Variables for the groups defined in `os-idr-playbooks/os-create.yml` as `omero_vm_groups` can be added under inventory/variables.


Deploying the IDR
=================


The production IDR is setup using a private configuration repository.
Replace `{{ inventory_dir }}` with the path to the inventory directory.
You can use `inventory` in this directory if you have configured the required variables, such as by creating a group_vars file if necessary in `{{ inventory_dir }}/group_vars/`, e.g. `{{ inventory_dir }}/group_vars/os-idr.yml`
This should match the value of the `idr_environment` variable (default `os-idr`), and can be used to support multiple deployment environments with different variables.

Decide on your openstack dynamic inventory.
If you are using a single floating IP use `{{ inventory_dir }}/openstack-private.py`.
using private internal IPs and a gateway server on the Openstack cloud.
If you are using floating IPs for all instances you can optionally use `{{ inventory_dir }}/openstack.py` instead.

Select your playbook, for instance `os-idr-uod.yml` for the Dundee cloud.

For example (using the default `os-idr` host-group and variables):

    ansible-playbook -i {{ inventory_dir }}/openstack-private.py os-idr-uod.yml
        -e vm_key_name="KEY_NAME" -e vm_prefix=PREFIX

Or using a custom group called `os-idrstaging` with additional variable overrides:

    ansible-playbook -i {{ inventory_dir }}/openstack-private.py os-idr-uod.yml
        -e vm_key_name="KEY_NAME" -e vm_prefix=PREFIX
        -e @vars/test-overrides.yml -e idr_environment=os-idrstaging


Component playbooks
-------------------

TODO:
