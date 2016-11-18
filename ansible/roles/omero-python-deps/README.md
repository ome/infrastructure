OMERO Python Dependencies
=========================

Python dependencies for OMERO.

OMERO depends on several Python modules, some of which can be installed from distribution packages or from PyPI (`pip`).

This role let's you choose between these two profiles:
- Use distribution packages except where they are known to be incompatible with OMERO (for example they are too old)
- Use recommended PyPI packages instead of distribution packages

In addition you can choose to install all recommended Python dependencies or a minimal subset which should allow OMERO to run, but with reduced functionality.
For example, if you are running OMERO.web standalone you may not need all dependencies.

If you switch between profiles this role will **not** uninstall packages since this may lead to the removal of other distribution packages which depend on a Python module.

Most users should use the defaults.


Dependencies
------------

Requires the EPEL repository (automatically setup by the `basedeps` role).
This role does not install the Ice Python module.


Role Variables
--------------

Optional variables:
- `omero_python_deps_recommended`: If `False` install a minimal set of Python dependencies, default `True`.

If `omero_python_deps_recommended` False then use virtualenv role

    - role: virtualenv
      virtualenv_user: "{{ youruser }}"
      virtualenv_path: /home/{{ youruser }}/virtualenv
      # virtualenv_site_packages: "yes"   # optional
      virtualenv_pip_rpm_dependencies:
      - gcc
      - libjpeg-devel
      - libtiff-devel
      - zlib-devel
      - python-pip
      virtualenv_pip_dependencies:
      - Pillow
      - Cython
      - numpy
      - matplotlib
      - tables
      - scipy
      - PyYAML

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
