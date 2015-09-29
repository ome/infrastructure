Role Name
=========

Install Zeroc Ice. Currently supports versions 3.5 (default) and 3.6.

Note that 3.6 requires ice-python to be installed using pip, and will result in the installation of several development tools and libraries.

TODO: The pip version is required in major.minor.patch form so
`vars/ice-3.6.yml` will need to be updated whenever there is a new patch
release.

TODO: Allow installation of a multi-version ice archive.

Role Variables
--------------

Optional variables:

- `ice_version`: The Ice version, either 3.5 (default) or 3.6

Internal variables: See `vars/*.yml`

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
