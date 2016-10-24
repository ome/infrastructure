OMERO user
==========

Create OMERO user accounts.
This will not modify existing user accounts, apart from the password if `force` is set.


Dependencies
------------

Assumes OMERO.web has already been installed with OMERO.server.


Role Variables
--------------

All variables are optional, see `defaults/main.yml`

Create OMERO user accounts:
- `omero_user_bin_omero`: The full path to `bin/omero` application, default `/home/omero/OMERO.server/bin/omero`
- `omero_user_system`: Run the `omero` CLI as this user, default `omero` (must not be `root`)
- `omero_user_admin_user`: Login to OMERO as this admin user, default `root`
- `omero_user_admin_pass`: Password for `omero_user_admin_user`
- `omero_user_create`: List of dictionaries of OMERO users to create with fields:
  - `login`: OMERO user-name
  - `firstname`: First name
  - `lastname`: Last name
  - `password`: Password
  - `groups`: String containing group arguments (see `bin/omero user add --help`)
  - `force`: Forcibly reset password, default `False` (requires direct database access)
- `omero_user_reset_root_password`: The new OMERO `root` password (requires direct database access)

Database connection parameters (required if forcibly resetting OMERO user passwords):
- `omero_user_dbhost`: Database host
- `omero_user_dbuser`: Database user
- `omero_user_dbname`: Database name
- `omero_user_dbpassword`: Database password


Example
-------

Create the user account `test-1` if it doesn't exist

    - hosts: omero-servers
      roles:
      - omero-user
      vars:
      - omero_user_admin_pass: "omero root password"
      - omero_user_create:
        - login: test-1
          firstname: test
          lastname: 1
          password: ome
          groups: "--group-name user"

This will reset the OMERO `root` password, then create the account `test-1` if it doesn't exist, and force a reset of the password if it does exist.

    - hosts: omero-servers
      roles:
      - omero-user
      vars:
      - omero_user_admin_pass: "omero root password"
      - omero_user_reset_root_password: "{{ omero_user_admin_pass }}"
      - omero_user_create:
        - login: test-1
          firstname: test
          lastname: 1
          password: ome
          groups: "--group-name user"
          force: True
      #- omero_user_dbhost: localhost
      #- omero_user_dbuser: omero
      #- omero_user_dbname: omero
      #- omero_user_dbpassword: omero


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
