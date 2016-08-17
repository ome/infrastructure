OMERO Server
============

Installs and configures OMERO.server, OMERO.web and optionally PostgreSQL.


Dependencies
------------

See `meta/main.yml`


Requirements
------------

This role may install additional requirements required by Ansible on the remote node.


Role Variables
--------------

All variables are optional, see `defaults/main.yml` for the full list

- `release`: The OMERO release, e.g. `5.2.2`.
This defaults to `latest`, but due to the broken registry a proper upgrade check has not been implemented so this will not have the expected effect (it will always attempt to upgrade even if the current server is the latest).
You are advised to change this to an actual release version.
- `postgresql_users_databases`: Used by the `postgres` role, if the PostgreSQL server is on the same node as the OMERO.server define this variable to create the local databases and users.
If a remote database server is used a user and empty database must already exist.
- `ice_version`: This variable originates from the `ice` role, leave unset for the default.


Warning
-------

If you modify your configuration without upgrading OMERO.server your web configuration will not be automatically regenerated.
You can force regeneration by deleting it.


Example Playbooks
-----------------

    # Install the latest release, including PostgreSQL on the same server
    - hosts: localhost
      roles:
      - role: omero-server
        postgresql_users_databases:
        - user: omero
          password: omero
          databases: [omero]

      # Install or upgrade to a particular version, use an external database
      - hosts: localhost
        roles:
        - omero-server
          omero_upgrade: True
          release: 5.2.2
          omero_dbhost: postgres.example.org
          omero_dbuser: db_user
          omero_dbname: db_name
          omero_dbpassword: db_password


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
