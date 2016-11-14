Openstack and IDR Playbooks
===========================

The Image data Repository (IDR) infrastructure is managed using [Ansible](https://www.ansible.com/).
This includes provisioning virtual resources on OpenStack.

Any queries should be sent to ome-devel@lists.openmicroscopy.org.uk


Background
----------

The main production IDR (https://idr-demo.openmicroscopy.org/) consists of three servers:
- Database:
  A dedicated PostgreSQL server.
- OMERO:
  OMERO.server and OMERO.web with a highly customised configuration optimised for the data access patterns of the IDR.
- Web proxy:
  Front-end Nginx proxy that mediates all public access to the IDR.
  It incorporates an aggressive caching configuration to reduce the load on OMERO.

Details of the configuration for these servers are in `idr-playbooks/group_vars/`.

The playbooks are designed to handle the setup of all servers together, including configuring internal network addresses so that OMERO can talk to the database, and the web proxy can talk to OMERO.

In addition to the production IDR we also have playbooks for setting up the analysis platform based around [JupyterHub](https://github.com/jupyterhub/jupyterhub) and [Docker Swarm](https://docs.docker.com/engine/swarm/).
This uses a separate copy of the IDR to ensure that heavy access loads resulting from analysis workflows do not have a detrimental impact on the production server, and requires three or more servers:
- Database
- OMERO:
  API access only, OMERO.web is currently installed by default but is not required
- Docker manager:
  The central controlling node for a Docker Swarm running JupyterHub.
- Docker workers:
  In addition to the Docker manager zero or more Docker workers can be included in the analysis platform.
  If multiple users are logged on to JupyterHub they should be automatically spread amongst all Docker servers.

TODO: Access to this platform is handled by the same web proxy used for the production IDR.

TODO: A diagram?

These instructions assume a working knowledge of Ansible, and will setup a combined production IDR and Analysis platform.
This should provided sufficient information for you to customise your installation to your own requirements.

The playbooks are mostly tested with OpenStack since that is our deployment platform, and this is the easiest way to setup the IDR.
They should also work with other clouds or physical infrastructure, but you will have to setup the Ansible inventory yourself.


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


TODO: The playbooks for the analysis platform are still being finalised/tested.


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
        idr-playbooks/idr-01-install-idr.yml \
        idr-playbooks/idr-02-install-analysis.yml

Also run `idr-playbooks/idr-03-postinstall.yml` if you wish to setup or reset the IDR OMERO user accounts.

This will generate a self-signed SSL certificate for the Nginx gateway.
