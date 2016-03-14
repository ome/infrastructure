Active Directory Join
=====================

Join a Linux server to an existing Active Directory domain.


Role Variables
--------------

`active_directory_realm`: The main AD domain
`active_directory_workgroup`: The samba workgroup
`active_directory_server`: A list of the AD servers
`active_directory_realmd_tags`: A list of AD realm tags
`active_directory_kerberos_realms`: A dict of the form `{REALM: [domain, ...]}` where keys are the realms and values are a list of domains associated with that realm

`active_directory_join_ou`: The domain/unit the server should be joined to
`active_directory_join_user`: The `username%password` of the AD administrative account used to join the node
`active_directory_join_access`: A list of user and/or group names that should be allowed to access this node
`active_directory_sssd_conf`: A variable containing the contents of `/etc/sssd/sssd.conf`, so that the contents of the file can be kept in a separate private repository
`active_directory_ssh_passwords`: `yes|no`, whether ssh access using passwords should be allowed, if omitted do not change the current configuration
`active_directory_user_homes`: The parent directory for user homes, required if they should be auto-created on login


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
