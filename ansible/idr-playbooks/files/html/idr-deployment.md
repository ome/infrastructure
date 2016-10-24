Openstack and IDR Playbooks
===========================

The Image data Repository (IDR) infrastructure is managed using [Ansible](https://www.ansible.com/).
This includes provisioning virtual resources on OpenStack.

Initial setup
-------------

The Ansible roles and playbooks are stored on [GitHub](https://github.com/openmicroscopy/infrastructure/).
Clone this directory, and change into the `ansible` directory:

    git clone --recursive https://github.com/openmicroscopy/infrastructure.git
    cd infrastructure/ansible

TODO: Link to a tag

The following sections in this document describe how to create the virtual machines and storage volumes for the IDR on OpenStack, and to install the IDR.
If you already have access to your own resources, whether physical or virtual, you can skip down to "Installing the IDR (own infrastructure)".


Creation of virtual machines and storage volumes on OpenStack
-------------------------------------------------------------

The playbooks used to provision the virtual hardware for the IDR contain private configuration information which is specific to our OpenStack tenancy.
An example playbook is provided: `os-idr-playbooks/os-idr-create-example.yml`.
Edit the variables in this playbook to correspond to your OpenStack project, and [setup your OpenStack environment variables](http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html).
Create the IDR resources by running:

    ansible-playbook os-idr-playbooks/os-idr-create-example.yml


Installing the IDR on Openstack
-------------------------------

The IDR OpenStack playbooks assume only one floating IP is available.
This means it is necessary to connect to servers via a bastion host.
This can be done by setting an SSH `ProxyCommand` in your SSH `config` file, or on the  Ansible command line.

A helper playbook `os-idr-playbooks/os-idr-ansible-command-helper.yml` is included to assist with setting the required Ansible SSH options:

    ansible-playbook -i inventory/openstack-private.py \
        os-idr-playbooks/os-idr-ansible-command-helper.yml \
        -e idr_environment=idr

`inventory/openstack-private.py` is an OpenStack dynamic inventory script that will return the private IPs of each instance. `idr_environment` is a variable intended to allow hosting of multiple IDR versions on the same tenancy, the default `idr` should work if you have only one IDR.

This playbook will write the Ansible command line to `/tmp/run-ansible-command.tmp`.
Edit this command if necessary, and run it, for example:

    ansible-playbook -i \
        idr-inventory/openstack-private.py \
        --diff \
        -u centos \
        -e idr_environment=idr \
        -e idr_nginx_ssl_self_signed=True \
        -e ansible_ssh_common_args="'-o ProxyCommand=\\\"ssh \
            -o UserKnownHostsFile=/dev/null \
            -o StrictHostKeyChecking=no \
            -W %h:%p -q centos@10.0.0.3\\\" \
            -o UserKnownHostsFile=/dev/null \
            -o StrictHostKeyChecking=no'" \
        idr-playbooks/idr-00-preinstall.yml \
        idr-playbooks/idr-01-install-idr.yml \
        idr-playbooks/idr-02-install-analysis.yml \
        idr-playbooks/idr-03-postinstall.yml


Installing the IDR (own infrastructure)
---------------------------------------

Create an Ansible inventory with the following groups:

    # PostgreSQL server
    [idr-database-hosts]
    10.0.0.1
    # OMERO server
    [idr-omero-hosts]
    10.0.0.2
    # Optional: Front-end web caching proxy
    [idr-proxy-hosts]
    10.0.0.3
    # Optional: analysis platform controller
    [idr-dockermanager-hosts]
    10.0.0.4
    # Optional: Analysis platform slave (multiple allowed)
    [idr-dockerworker-hosts]
    10.0.0.5

Install the IDR:

    ansible-playbook \
        -i inventory \
        -e idr_nginx_ssl_self_signed=True \
        idr-playbooks/idr-01-install-idr.yml \
        idr-playbooks/idr-02-install-analysis.yml

Also run `idr-playbooks/idr-03-postinstall.yml` if you wish to setup or reset the IDR OMERO user accounts.
