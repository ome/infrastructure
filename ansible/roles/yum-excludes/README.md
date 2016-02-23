Yum Excludes
============

Manage a list of packages the are excluded from updates.
This role assumes it has full control of the `excludes=` line in `/etc/yum.conf`, manual changes will be lost.


Role Variables
--------------

Optional variables:

- `yum_excludes_packages`: A of packages to exclude, for example `[kernel-*, systemd-*]`.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
