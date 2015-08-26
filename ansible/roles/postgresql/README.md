Postgresql
==========

Install upstream PostgreSQL server.

Role Variables
--------------

Defaults: `defaults/main.yml`

- `postgresversion`: The PostgreSQL version, either 9.4 (default) or 9.3
- `postgressubpackages`: Sub-packages to install in addition to the clients, defaults is to also install the server. Set this to empty if you only want the clients.
- `runningindocker`: systemd doesn't currently work inside Docker without some fiddling. Set this variable to `True` to call the database initdb and start scripts directly, default `False`.

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
