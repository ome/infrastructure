Openstack IDR Instance
======================

Create an Openstack VM for use with the IDR playbooks.


Role Variables
--------------

Defaults: `defaults/main.yml`

Required variables:
- `idr_vm_name`: VM hostname
- `idr_vm_image`: Openstack base image
- `idr_vm_keyname`: Openstack SSH key
- `idr_vm_flavour`: Openstack flavour

Optional variables:
- `idr_vm_private_network`: Use this network instead of the default one
- `idr_vm_assign_floating_ip`: Assign a floating IP, default `False`
- `idr_environment`: Use this as a group prefix. You should almost always set this to something other than the default `idr`

Booleans indicating the purpose of this server:
- If any of these are `True` they will be used to automatically set the security groups and host-groups for this VM, default `False`. Multiple may be set to `True` if a server has multiple purposes.
  - `idr_vm_database`: An IDR database server
  - `idr_vm_omero`: An IDR OMERO server
  - `idr_vm_proxy`: An IDR web proxy server

Advanced settings:
- `idr_vm_groups`: A list of host-groups, default depends on the above booleans
- `idr_vm_extra_groups`: A list of host-groups in addition to the above default
- `idr_vm_security_groups`: A list of security groups, default depends on the above booleans


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
