OMERO Web Applications
======================

Install OMERO.web plugins.


Dependencies
------------

Assumes OMERO.web has already been installed with OMERO.server.

This also assumes the following variables from `roles/omero-server` are defined:
- `omero_serverdir`
- `omero_server_symlink`
- `omero_system_user`
- `omero_systemd_setup`


Role Variables
--------------

All variables are optional, see `defaults/main.yml` for the full list

- `omero_web_app_packages`: List of pip installable packages or URLs
- `omero_web_apps_add`: List of web application names to be included in `omero.web.apps`
- `omero_web_app_add_top_links`: Dictionary of lists to be included in `omero.web.ui.top_links`.
  This must be a YAML object, which will be auto-converted to JSON.


Example
-------

TODO


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
