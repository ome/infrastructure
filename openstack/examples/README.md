OMERO VM Deployment
===================

This contains example files for provisioning an OpenStack VM from scratch with OMERO using Ansible.
Most of these scripts should also work on other platforms, providing the VM is brought up by some other method.
The guest must be running CentOS 7.


Guide for the Impatient
-----------------------

Setup your OpenStack environment variables, and run:

    ansible-playbook os-create.yml -e omero_vm_name=FOO -e omero_vm_key_name=YOURKEY
    ANSIBLE_ROLES_PATH=../../ansible/roles/ ansible-playbook -i inventory -l 'FOO' os-omero.yml

Some of the more specific deployment scripts may work depending on your environment:

    ANSIBLE_ROLES_PATH=../../ansible/roles/ ansible-playbook -i inventory \
        -e omero_vm_name=FOO -e omero_vm_key_name=YOUR_KEY uod-os-idr-omero.yml


`os-omero.yml`
--------------

This is the Ansible playbook that will be run to setup OMERO.
You can also run it manually to install OMERO on localhost.


`os-create.yml`
---------------

This playbook will connect to OpenStack and spin up a VM.
The Ansible modules in this playbook require the `shade` Python module.

Before running the playbook you must [setup your OpenStack environment variables](http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html).
You can override variables at the command line, for example (note double quoting is necessary if spaces are present):

    ansible-playbook os-create.yml -e omero_vm_name=FOO -e omero_vm_key_name=YOURKEY \
        -e "omero_vm_flavour='m2.xxlarge'"

If this step fails it could be due to an incorrect variable, the Ansible `os_server` module usually gives an uninformative "Error in creating instance" message.
If the VM was created the floating IP of the VM will be printed out.

To delete the VM and related security group:

    ansible-playbook os-delete.yml -e omero_vm_name=FOO

If another instance is using the OMERO security group, the task will fail but can be safely ignored.

Inventory
---------

This directory takes advantage of an
[Ansible dynamic inventory script for OpenStack (`openstack.py`)](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-openstack-external-inventory-script)
instead of having to manage an inventory file when using Ansible to push out changes.
For example:

    ANSIBLE_ROLES_PATH=../../ansible/roles ansible-playbook -i inventory -l os-image-centos os-omero.yml -vv

Variables for the groups defined in os-create.yml as omero_vm_groups can be added under inventory/variables.
