Active Directory Samba Share
============================

Manage samba file shares with authentication provided by active directory.
If the `active-directory-join` role is also present on this server it should be run before this role, and common variables must match.

If you are running SELinux see http://selinuxproject.org/page/SambaRecipes


Role Variables
--------------

`active_directory_realm`: The main AD domain
`active_directory_workgroup`: The samba workgroup
`active_directory_shares`: A dictionary of dictionaries of shares in the form `{share-name: { path: , comment: (optional), readonly: (default True), users: [list of users/groups] }}`


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: active-directory-samba-share
        active_directory_realm: AD.EXAMPLE.ORG
        active_directory_workgroup: workgroup
        active_directory_shares:
          share-ro:
            path: /srv/samba/ro
            comment: Read-only share
            users: [root]

          share-rw:
            path: /srv/samba/rw
            comment: Read-write share
            readonly: False
            users: [root]


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
