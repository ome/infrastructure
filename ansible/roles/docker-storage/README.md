Docker Storage
==============

Setup LVM storage partitions for Docker.

Creates thin-pool logical volumes for Docker, and a normal logical volume for `/var/lib/docker`.

Role Variables
--------------

These variables must be defined (defaults aren't provided):

- `vgname`: LVM volume group for the logical volumes
- `dockerpoolsize`: Size of the Docker thin-pool partition
- `dockervolumesize`: Size of the `/var/lib/docker` partition
- `lvfilesystem`: filesystem for the Docker volume partition

Optional variables:

- `lvopts`: Logical volume creation options (default: None)

Dependencies
------------

Depends on lvm-partition

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
