Openstack IDR Instance Network
==============================

Add one or more networks to an existing OpenStack instance.


Dependencies
------------

This currently requires the `nova` command line client to be in your path.
At the time of writing the `openstack` client doesn't support adding interfaces to existing instances.


Role Variables
--------------

Required variables:
- `idr_instance_network_server`: The instance to be modified
- `idr_instance_network_networks`: A list of networks the server should be connected to.
  If the instance is connected to other networks which aren't in this list they *won't* be removed from the server.


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: openstack-idr-instance-network
        idr_instance_network_server: idr-gateway-server
        idr_instance_network_networks:
        - existing-network
        - new-network-1

    # After connecting the network to the instance you may want to initialise
    # the corresponding NIC inside the instance. For example (this will not
    # affect existing NICs):
    - hosts: idr-gateway-server
      roles:
      - role: network-cloud-interfaces


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
