Docker
======

Setup Docker, provides options for using an advanced storage or networking configuration.
Installs the latest official upstream Docker (**not** the distribution version).


Role Variables
--------------

Defaults: `defaults/main.yml`

- `docker_use_custom_storage`: If `True` use a custom storage configuration, default `False`
- `docker_use_custom_network`: If `True` use a custom network configuration, default `False`

Custom storage: If `docker_use_custom_storage` is `True` thin-pool logical volumes will be created for Docker, and a separate logical volume will be created for the Docker volume (`/var/lib/docker`).
This is highly recommended for production use.

- `docker_basefs`: Filesystem to use for the Docker containers (default xfs)
- `docker_lvfilesystem`: Filesystem for the Docker volume (default xfs)

The following variables must be defined:

- `docker_vgname`: LVM volume group for the logical volumes
- `docker_poolsize`: Size of the Docker thin-pool partition
- `docker_metadatasize`: Size of the Docker thin-pool metadata partition (try 1% of the poolsize)
- `docker_volumesize`: Size of the Docker volume

Custom networking: If `docker_use_custom_network` is `True` a custom network bridge will be used, this must be created outside of this role.
The following variables must be defined:

- `docker_bridge_name`: The name of a custom network bridge for docker
- `docker_bridge_ips`: The custom IP range that docker should use for allocating IPs

Optional variables:

- `docker_lvopts`: Additional arguments to be used when creating logical volumes
- `docker_groupmembers`: A list of users who will be added to the `docker` system group, allows docker to be run without sudo
- `docker_use_ipv4_nic_mtu`: Force Docker to use the MTU set by the main IPV4 interface. This may be necessary on virtualised hosts, see comment in `defaults/main.yml`.
- `docker_repo_version`: Use a different upstream Docker release branch e.g. `testing`, do not change this unless you know what you are doing
- `docker_groupmembers`: List of non-admin users who can run `docker`


Dependencies
------------

Depends on lvm-partition


Upgrades
--------

If you are using advanced networking or storage this role will override the `docker.service` file included in the distributed packages. If an upgrade to docker is planned you are advised to check for differences in `/usr/lib/systemd/system/docker.service` between the old and new RPMs, and if necessary merge any changes into `files/docker.service` in this role.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
