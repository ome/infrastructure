OMERO user
==========

Create OMERO user accounts and groups.
This will not modify existing users or groups, apart from the user password if `force` is set.


Dependencies
------------

Assumes the `omero-server` role is installed with defaults, if not you will have to set most of the role variables below.

This requires features present in OMERO 5.X.


Role Variables
--------------

All variables are optional, see `defaults/main.yml`

Create OMERO user accounts and groups:
- `omero_user_bin_omero`: The full path to `bin/omero` application, default `/home/omero/OMERO.server/bin/omero`
- `omero_user_system`: Run the `omero` CLI as this user, default `omero` (must not be `root`)
- `omero_user_admin_user`: Login to OMERO as this admin user, default `root`
- `omero_user_admin_pass`: Password for `omero_user_admin_user`

- `omero_user_create`: List of dictionaries of OMERO users to create with fields:
  - `login`: OMERO user-name
  - `firstname`: First name
  - `lastname`: Last name
  - `password`: Password
  - `groups`: String containing group arguments (see `bin/omero user add --help`), this must be quoted if the group-names contain spaces or other special characters
  - `force`: Forcibly reset password, default `False` (requires direct database access)
- `omero_user_reset_root_password`: The new OMERO `root` password (requires direct database access)
- `omero_group_create`: List of dictionaries of OMERO groups to create with fields:
  - `name`: Group name
  - `type`: Group type

Database connection parameters (required if forcibly resetting OMERO user passwords):
- `omero_user_dbhost`: Database host
- `omero_user_dbuser`: Database user
- `omero_user_dbname`: Database name
- `omero_user_dbpassword`: Database password


Example
-------

Create the user account `public` and group `demo` if it doesn't exist

    - hosts: omero-servers
      roles:
      - omero-user
      vars:
      - omero_group_create:
        - name: demo
          type: read-only
      - omero_user_create:
        - login: public
          firstname: public
          lastname: user
          password: public
          groups: "--group-name demo"

Reset the OMERO `root` password:

    - hosts: omero-servers
      roles:
      - omero-user
      vars:
      - omero_user_reset_root_password: "omero root password"
      #- omero_user_dbhost: localhost
      #- omero_user_dbuser: omero
      #- omero_user_dbname: omero
      #- omero_user_dbpassword: omero


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
