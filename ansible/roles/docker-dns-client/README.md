Docker DNS Client
=================

Set up the registrator service for updating the Docker DNS server with the currently running containers.
TODO: Currently this only works when run on the same host as the server.

Role Variables
--------------

The defaults will work unless the name of the `etcd` container has been changed:

- `dockerdns.etcd`: Runtime name of the `etcd` container, default: `etcd1`

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
