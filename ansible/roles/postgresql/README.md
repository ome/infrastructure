Postgresql
==========

Install upstream PostgreSQL server.
Optionally creates users and databases.


Role Variables
--------------

Defaults: `defaults/main.yml`

- `postgresql_version`: The PostgreSQL version, either 9.4 (default) or 9.3
- `postgresql_install_server`: If True (default) install and initialise the server, otherwise only install the client
- `postgresql_users_databases`: List of dictionaries of users and databases, ignored unless `postgresql_install_server` is `True`. Items should be of the form:
  - `user`: Database username
  - `password`: Database user password
  - `databases`: [List of database names that user has access to]
  - `roles`: Role attribute flags, optional
- `postgresql_server_listen`: Listen on these interfaces, default `localhost`, use `'*'` for all
- `postgresql_server_auth_local`: Whether to allow the default postgres local authentication (default `True`)
- `postgresql_server_auth`: List of dictionaries of authorisation parameters, if omitted the default local authentication only will be enabled. Items should be of the form:
  - `database`: Name of the database
  - `user`: Username
  - `address`: Address from which connections will be made
  - `method`: Ignore this unless you really know what you are doing
- `postgresql_server_chown_datadir`: If `True` recursively reset the owner and group of the postgres datadir, default `False`, use this when you have an existing datadir with incorrect owner/group


Example Playbook
----------------

    - hosts: localhost
      roles:
      - postgresql
      vars:
      - postgresql_server_listen: "'*'"
      - postgresql_server_auth:
        - database: publicdb
          user: alice123
          address: 192.168.1.0/24
      - postgresql_users_databases:
        - user: alice
          password: alice123
          databases: [publicdb, secretdb]
        - user: bob
          password: bob123
          databases: [publicdb]



Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
