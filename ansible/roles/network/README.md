Network
=======

Set up custom network interface configurations for a server.


Role Variables
--------------

- `network_ifaces`: A list of dictionaries, one per network device, of network parameters which will be substituted into `templates/etc-sysconfig-network-scripts-ifcfg.j2`.
- `network_ifaces[].device`: The device name. All other fields are optional, see the template for details.
- `network_ifaces[].bondmaster`: If specified this NIC will be part of a bonded interface. If the `device` name matches `bondmaster` it will be set as the master, otherwise it will be a slave of `bondmaster`.
- `network_delete_ifaces`: A list of network device names to be removed.


Example Playbook
----------------

    # Simple network
    - hosts: localhost
      roles:
      - role: network
        network_ifaces:
        - device: eth0
          ip: 192.168.1.1
          netmask: 255.255.255.0
          type: ethernet
          gateway: 192.168.1.254
          dns1: 8.8.4.4
          dns2: 8.8.8.8

    # Bonded network combining eth0 and eth1
    - hosts: localhost
      roles:
      - role: network
        network_ifaces:
        - device: bond0
          ip: 192.168.1.1
          prefix: 24
          gateway: 192.168.1.254
          dns1: 8.8.4.4
          dns2: 8.8.8.8
          bondmaster: bond0
        - device: eth0
          bondmaster: bond0
        - device: eth1
          bondmaster: bond0


Notes
-----

- If you change the network settings it may be restarted, which means your connection from Ansible may be broken.
- If you are using this role to set a network IP after a system has been PXEed you may need to temporarily set `ansible_host` in your host inventory if DNS isn't already setup for the host.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
