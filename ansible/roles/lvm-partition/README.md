LVM Partition
=============

Additional LVM logical volumes to be created and mounted.

Role Variables
--------------

These variables must be defined (defaults aren't provided):

- `vgname`: LVM volume group for the logical volume
- `lvname`: Logical volume name, use `[A-Aa-z0-9]+` to avoid problems
- `lvmount`: Where the partition should be mounted
- `lvsize`: Size of the partition
- `lvfilesystem`: filesystem for partitions which need to be formatted

Optional variables:

- `lvopts`: Logical volume creation options (default: None)

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
