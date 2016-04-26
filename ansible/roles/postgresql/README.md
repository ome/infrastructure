Postgresql
==========

Install upstream PostgreSQL server.
Optionally creates users and databases.


Role Variables
--------------

Defaults: `defaults/main.yml`

- `postgresql_version`: The PostgreSQL version, either 9.4 (default) or 9.3
- `postgresql_install_server`: If True (default) install and initialise the server, otherwise only install the client
- `postgresql_users_databases`: List of dictionaries of users and databases in the form `[{user: db-user, password: db-password, databases: [List of database names]}]`, only works if `postgresql_install_server` is `True`


Example Playbook
----------------

    - hosts: localhost
      roles:
      - postgresql
      vars:
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
