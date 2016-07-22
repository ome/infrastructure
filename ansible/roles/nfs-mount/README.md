NFS Mount
=========

Manage NFS4 mounts.


Role Variables
--------------

- `nfs_share_mounts`: List of dictionaries of NFS shares: `{ path: mount-point, mount: nfs server path, opts: mount options (optional) }`
- `nfs_mount_opts`: Default NFS4 mount options


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: nfs-mount
        nfs_share_mounts:
        - path: /mnt/remote
          location: nfs.example.org:/data
        - path: /mnt/readonly
          location: nfs.example.org:/read-only
          opts: "{{ nfs_mount_opts }},ro"


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
