Hosts Populate
==============

Populates `/etc/hosts` with static addresses for a list of hostgroups.


Role Variables
--------------

Optional variables:
- `hosts_populate_iface`: Lookup the host IP using this network interface, default `eth0`
- `hosts_populate_openstack_groups`: List of openstack groups, hosts from these groups will be included in `/etc/hosts`.
  In practice this will probably work with non-openstack groups too.

Warning: This role requires full control of `/etc/hosts`.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
