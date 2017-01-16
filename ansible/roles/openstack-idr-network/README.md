Openstack IDR Network
=====================

Create an Openstack network including external router for use with the IDR playbooks.


Role Variables
--------------

Defaults: `defaults/main.yml`

Required variables:
- `idr_network_name`: Base name for the IDR network components
- `idr_network_external_name`: Name of the external network (this should be created by an OpenStack admin)

Optional variables:
- `idr_network_subnet`: Subnet CIDR
- `idr_network_subnet_name`: Subnet name
- `idr_network_router_name`: Router name
- `idr_network_dns`: List of DNS servers (default: Google DNS server)

- `idr_environment`: Use this as a group prefix. This is required to ensure servers can lookup the address of other servers in the group, and is particularly important if multiple groups of servers are running in the same project. The default is `idr` but you should almost always set it to something else.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
