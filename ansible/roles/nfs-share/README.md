NFS Share
=========

Manage NFS file shares (no authentication).

Note if SELinux is enabled you may need modify the configure of the the shared directories (not handled by this role).


Role Variables
--------------

`nfs_shares`: A dictionary of lists of hosts and options `{/exported/directory: [{ host: host-pattern, options: options (optional) }, ...] }`

Note the default NFS share options in this role (`ro,all_squash`) are slightly more restrictive than the original NFS defaults.


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: nfs-share
        nfs_shares:
          # Allow access from *.example.org with default options
          /srv/share1:
            - host: "*.example.org"

          # Allow read-write access from two subnets, squash all except root
          /srv/share2:
            - host: 192.168.1.0/25
              options: rw,root_squash
            - host: 172.16.0.0/20
              options: rw,root_squash


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
