OMERO Server
============

Installs and configures OMERO.server, OMERO.web and optionally PostgreSQL.


Dependencies
------------


Requirements
------------


Role Variables
--------------

All variables are optional, see `defaults/main.yml` for the full list

- `release`: The OMERO release, e.g. `5.2.2`


Example Playbook
----------------

    - hosts: localhost
      roles:
      - omero-server


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
