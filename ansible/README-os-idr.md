Openstack and IDR Playbooks
===========================


OMERO OpenStack VM Deployment
-----------------------------

This repository contains example files for provisioning an OpenStack VM from scratch with OMERO using Ansible, as used by the Image data Repository.
Most of these scripts should also work on other platforms, providing the VM is brought up by some other method.
The guest must be running CentOS 7.


Openstack: Creation of instances, volumes and security groups
-------------------------------------------------------------

[Setup your OpenStack environment variables](http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html), edit the variables in `os-idr-playbooks/os-idr-create-example.yml` (especially `idr_vm_keyname` and `idr_environment`), then run:

    ansible-playbook os-idr-playbooks/os-idr-create-example.yml


Openstack: Installing the IDR
-----------------------------

Find the floating IP of the proxy/bastion server.
Set `BASTION_IP` to the IP, and `IDR_ENVIRONMENT` to match the value from above.
Run:

    BASTION_IP=10.0.0.0
    IDR_ENVIRONMENT=idr
    ansible-playbook \
        -i inventory/openstack-private.py \
        -u centos \
        -e idr_environment=$IDR_ENVIRONMENT \
        -e idr_nginx_ssl_self_signed=True \
        -e ansible_ssh_common_args="'-o ProxyCommand=\\\"ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p -q centos@$BASTION_IP\\\" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'" \
        idr-playbooks/os-idr-volumes.yml \
        idr-playbooks/idr-dundee-nfs.yml \
        idr-playbooks/idr-ebi-nfs.yml \
        idr-playbooks/idr.yml \
        idr-playbooks/idr-docker.yml


Deploying the IDR on existing infrastructure
--------------------------------------------

If you have already created your servers and just wish to install a plain IDR then run:

    ansible-playbook \
        -i inventory \
        -u centos \
        -e idr_environment=$IDR_ENVIRONMENT \
        -e idr_nginx_ssl_self_signed=True \
        idr-playbooks/idr-omero.yml

where `inventory` contains groups described in the following section.


`idr-playbooks/idr-omero.yml`
-----------------------------

This is the Ansible playbook that will be run to setup OMERO.
This can be run independently of the openstack playbooks providing you have an inventory with groups:
- `{{ idr_environment }}-data-hosts`
- `{{ idr_environment }}-omero-hosts`
- `{{ idr_environment }}-proxy-hosts`


TODO: explain other `idr-playbooks/*.yml` playbooks


Deploying the IDR
=================

Component playbooks
-------------------

TODO:
