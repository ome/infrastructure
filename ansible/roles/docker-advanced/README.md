Docker Advanced
===============

Advanced installation and configuration of Docker.
Assumes storage has been configured.
Also sets up groups and users.
If you don't need a special setup then use the docker role instead.

Requirements
------------

Requires the docker-storage role to have been already run, since this disables the default Docker storage configuration.
docker-storage is not automatically added since it involves hardware configuration.

Role Variables
--------------

These variables must be defined (defaults aren't provided):

- `vgname`: The volume group used in `docker-storage`. This is necessary because the docker setup process requires the name of the raw logical volume device.

Optional variables:

- `dockerbridge.name`: The name of a custom network bridge for docker
- `dockerbridge.ips`: The custom IP range that docker should use for allocating IPs
- `dockergroupmembers`: A list of users who will be added to the `docker` system group, allows docker to be run without sudo

Dependencies
------------

The `docker-storage` role must have been run separately.

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
