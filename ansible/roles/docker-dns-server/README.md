Docker DNS Server
=================

Setup a dynamic DNS service for Docker containers. This can optionally be defined as the authority for a subdomain in an upstread DNS server.

Role Variables
--------------

Although defaults are provided it is highly recommended that you customise the configuration.

- `docker_dns.forwarders`: Forward queries for other domains to these servers, default: `8.8.8.8:53,8.8.4.4:53`
- `docker_dns.domain`: Domain for the DNS service, default: `docker.internal` so the DNS will respond to queries for `*.docker.internal`
- `docker_dns.etcd: Runtime name of the `etcd` container, default: `etcd1`

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
