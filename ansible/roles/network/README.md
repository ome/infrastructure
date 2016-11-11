Network
=======

Set up custom network interface configurations for a server.


Role Variables
--------------

- `network_ifaces`: A list of dictionaries, one per network device, of network parameters which will be substituted into `templates/etc-sysconfig-network-scripts-ifcfg.j2`.
- `network_ifaces[].device`: The device name. All other fields are optional, see the template for details.
- `network_ifaces[].bondmaster`: If specified this NIC will be part of a bonded interface. If the `device` name matches `bondmaster` it will be set as the master, otherwise it will be a slave of `bondmaster`.
- `network_disable_ifaces`: A list of network device names to be explicitly disabled, use this if you want to be sure the interface is disabled (as opposed to being auto-configured by the system).
- `network_delete_ifaces`: A regular expression describing the network device name(s) to be removed (note this means the system may auto-configure them), use this for cleaning up spare configuration files.

The above variables provide full control of all network interfaces on a server, and will almost always require a restart of the network service on the server.

For convenience an alternative variable for adding interfaces with very simple configuration is available that will restart only the added interface.
This should only be used where it is critical that connections to existing NICs are maintained, and is not recommended since the state of the system may not match the state after a full restart.
- `network_basic_ifaces`: Adds and restart individual interfaces, use `network_ifaces` unless you really need this.



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
- In some cases restarting the network is insufficient, you may need to reboot.
- If you are using this role to set a network IP after a system has been PXEed you may need to temporarily set `ansible_host` in your host inventory if DNS isn't already setup for the host.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
