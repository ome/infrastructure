Openstack Volume Storage
========================

Create and attach a volume to an Openstack instance.

Note this requires Ansible 2.3 features in `os_volume`.
A bundled version of the updated module is temporarily included as `library/os_volume_ansible23.py`.


Role Variables
--------------

Required variables:

- `openstack_volume_size`: Size of the volume in GB
- `openstack_volume_vmname`: The name of the instance the volume should be attached to
- `openstack_volume_name`: The name of the volume
- `openstack_volume_device`: The device name of the volume in the instance (default: automatically determined by Openstack)


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
