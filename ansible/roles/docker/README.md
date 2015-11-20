Docker
======

Setup Docker, provides options for using an advanced storage or networking configuration.


Role Variables
--------------

Defaults: `defaults/main.yml`

- `docker_use_upstream_repo`: If `True` use the latest official upstream Docker, default (`False`) is to install Docker from the distribution repositories
- `docker_use_custom_storage`: If `True` use a custom storage configuration, default `False`
- `docker_use_custom_network`: If `True` use a custom network configuration, default `False`

Custom storage: If `docker_use_custom_storage` is `True` thin-pool logical volumes will be created for Docker, and a separate logical volume will be created for the Docker volume (`/var/lib/docker`).
This is highly recommended for production use.
The following variables must be defined:

- `docker_vgname`: LVM volume group for the logical volumes
- `docker_poolsize`: Size of the Docker thin-pool partition
- `docker_metadatasize`: Size of the Docker thin-pool metadata partition (try 1% of the poolsize)
- `docker_basefs`: Filesystem to use for the Docker containers (e.g. ext4, xfs)
- `docker_volumesize`: Size of the Docker volume
- `docker_lvfilesystem`: Filesystem for the Docker volume

Custom networking: If `docker_use_custom_network` is `True` a custom network bridge will be used, this must be created outside of this role.
The following variables must be defined:

- `docker_bridge_name`: The name of a custom network bridge for docker
- `docker_bridge_ips`: The custom IP range that docker should use for allocating IPs

Optional variables:

- `docker_lvopts`: Additional arguments to be used when creating logical volumes
- `docker_groupmembers`: A list of users who will be added to the `docker` system group, allows docker to be run without sudo


Dependencies
------------

Depends on lvm-partition

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
