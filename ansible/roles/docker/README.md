Docker
======

Setup Docker using the default setup script instead of manually configuring partitions, and using the default internal bridge/NAT network configuration.

Creates thin-pool logical volumes for Docker, and a normal logical volume for `/var/lib/docker`.

Role Variables
--------------

These variables must be defined (defaults aren't provided):

- `vgname`: LVM volume group for the logical volumes
- `dockerpoolsize`: Size of the Docker thin-pool partition
- `dockervolumesize`: Size of the `/var/lib/docker` partition
- `lvfilesystem`: filesystem for the Docker volume partition

Optional variables:

- `dockergroupmembers`: A list of users who will be added to the `docker` system group, allows docker to be run without sudo

Dependencies
------------

Depends on lvm-partition

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
