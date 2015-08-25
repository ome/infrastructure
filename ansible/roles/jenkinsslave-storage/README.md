Role Name
=========

Setup a LVM storage partition for the Jenkins slave.

Role Variables
--------------

These variables must be defined (defaults aren't provided):

- `vgname`: LVM volume group in which the LVM should be created
- `jenkinssize`: Size of the Jenkins partition
- `jenkinsworkdir`: Mountpoint for the Jenkins work partition

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
