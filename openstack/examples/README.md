OMERO VM Deployment
===================

This contains example files for provisioning an OpenStack VM from scratch with OMERO using Ansible.
Most of these scripts should also work on other platforms, providing the VM is brought up by some other method.
The guest must be running CentOS 7.


Guide for the Impatient
-----------------------

Setup your OpenStack environment variables, and run:

    ansible-playbook idr-os-playbook.yml

Wait for Ansible to return, and wait some more since the OMERO setup process continues in the background on the VM.


`idr-example-omero-bootstrap.sh`
--------------------------------

This script will be run automatically by OpenStack cloud-init after creating a VM.
Modify it before deploying the VM if you want to change any parameters.
Note that it will clone this repository from GitHub, so changes to other files will not be included.
If you are using another platform first create your VM, copy this file into the VM, and run it as `root` to setup OMERO.


`idr-example-omero.yml`
-----------------------

This is the Ansible playbook that will be run to setup OMERO.
You can also run it manually to install OMERO on localhost, see `idr-example-omero-bootstrap.sh`.


`idr-os-playbook.yml`
---------------------

This playbook will connect to OpenStack, spin up a VM, and pass `idr-example-omero-bootstrap.sh` to cloud-init.
The Ansible modules in this playbook require the `shade` Python module.

Before running the playbook you must [setup your OpenStack environment variables](http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html).
You will need to edit some of the variables in the file to match your OpenStack installation: `omero_vm_key_name`, `omero_vm_image`, `omero_vm_flavour`.
Then run:

    ansible-playbook idr-os-playbook.yml

Alternatively you can override variables at the command line, for example (note double quoting is necessary if spaces are present):

    ansible-playbook idr-os-playbook.yml -e "omero_vm_key_name='My Keypair'"

If this step fails it could be due to an incorrect variable, the Ansible `os_server` module usually gives an uninformative "Error in creating instance" message.
If the VM was created the floating IP of the VM will be printed out.

The `idr-example-omero-bootstrap.sh` script will continue to run in the background on the VM.
To monitor it's progress see the VM logs in the OpenStack Horizon web interface, or on the command line (there isn't a follow option):

    watch nova console-log --length 10 test-idr-omero

To see the full logs:

    nova console-log test-idr-omero

The advantage of running this playbook from inside the VM instead of pushing it out is that no SSH authentication needs to be setup, and it is not necessary to wait for the VM to initialise its SSH server.

To delete the VM and related security group:

    ansible-playbook idr-os-playbook-delete.yml
