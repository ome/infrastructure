OME Ansible
===========

This contains a variety of Ansible playbooks and roles, including example files for provisioning an OpenStack VM from scratch with OMERO using Ansible.
Most of these scripts should also work on other platforms, providing the VM is brought up by some other method.

- Playbooks which start with `os` are OpenStack specific - the `os` stands for `OpenStack`.
- Playbooks which start with `idr` are for the Image Data Repository.
- Playbooks which start with `ci` are for OME continuous integration and build.

To get started with a minimal OMERO server, use the example playbook in the [README.md of roles/omero-server](/roles/omero-server/README.md).

OME OpenStack Ansible
----------------------

For the OpenStack specific README, see: [Getting started with OME OpenStack Ansible](README-os.md)

For the IDR specific OpenStack README, see: [IDR OpenStack](README-os-idr.md)
