NFS Ganesha Share
=================

Manage NFS user mode (Ganesha) file shares (no authentication).

Note if SELinux is enabled you may need modify the configure of the the shared directories (not handled by this role).


Conflicts
---------

The NFS Ganesha server conflicts with the standard kernel NFS server, you can only run one.


Role Variables
--------------

All variables are optional, though if `nfs_ganesha_shares` is unset the role is rather useless:
- `nfs_ganesha_shares`: A list of dictionaries exports, hosts and options `{ path: /exported/directory, pseudopath: /pseudo/path (optional), fs: ganesha fs type (optional), clients: [{ host: host-cidr, access: RO|RW (optional), squash: None|Root|All (optional) }, ...] }`
- `nfs_ganesha_default_log_level`: Change the default logging level

The default options are `access: RO`, `squash: All`.
Currently only the default of `fs: VFS` is supported by this role.
For full details of configuration options see https://github.com/nfs-ganesha/nfs-ganesha/blob/master/src/config_samples/export.txt

Note: during testing nfs-ganesha sometimes behaved inconsistently when processing the access rules in `/etc/ganesha/ganesha.conf`.
I have no idea why.
If you are trying to debug access problems note that at present (2016-07-21) the output of `showmount` may be incorrect.


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: nfs-ganesha-share
        nfs_ganesha_shares:
        - path: /srv/share1
          pseudopath: /share1
          clients:
          - host: "192.168.1.0/25"
        - path: /srv/share2
          pseudopath: /share2
          clients:
          - host: "192.168.1.0/25, 172.16.0.0/20"
            access: RW
            squash: Root


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
