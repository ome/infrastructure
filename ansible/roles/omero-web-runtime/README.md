OMERO Web Runtime
=================

OMERO.web runtime dependencies.

Mostly Python modules.

Dependencies
------------

Depends on `basedeps`, `ice` and `omero-python-deps`.
Optionally depends on `redis`.

By default `omero-python-deps` is installed with the default (recommended) options.
If you wish you can set `omero_python_deps_recommended: False` to only install the minimum requirements.


Role Variables
--------------

Optional variables:
- `omero_web_runtime_redis`: If `True` install redis dependencies, default `False`


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
