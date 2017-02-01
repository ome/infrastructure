OME Infrastructure Docs
=======================

General documentation and workflows related to the OME's system infrastructure.
Although these documents are tailored for the OME's systems they should be useful for others wishing to setup similar infrastructure.

The infrastructure repository is centred around the use of Ansible, and a lot of information can be found in the README files of individual Ansible roles.
This folder contains higher-level documentation, or information that doesn't fit elsewhere.

Inevitably some private configuration information has been omitted.


Ansible
-------

- [Ansible](ansible/ansible.md): Overview of Ansible, the configuration management system.
- [Example workflows](ansible/example_workflows.md): Examples of provisioning new hosts, and running Ansible playbooks.
- [Contributing](ansible/contributing.md): Suggestions on submitting modifications and extensions to the OME ansible roles and playbooks.


Storage
-------

- [GPFS](storage/gpfs.md): useful commands for managing GPFS filesystems.
