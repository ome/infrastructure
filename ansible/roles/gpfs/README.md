GPFS
====

Extract GPFS RPMs from their distributed package and build a kernel module RPM.
Setup a GPFS client.

Work in progress.


Requirements
------------

Building:
Ensure all system packages are updated. The GPFS kernel module will be compiled for the kernel currently running on the machine (so reboot if it has been updated).
This role will attempt to install the following kernel-related packages if they are missing:

- kernel-devel
- kernel-headers
- kernel-tools
- kernel-tools-libs

However if you are running an older kernel it is sometimes possible for a more recent version of these packages to be automatically installed, which will lead to failure of the kernel module build.
To avoid these problems it is highly recommended that you install these packages first and verify that their versions match the kernel version exactly.

TODO: Add error checking of kernel package versions at start.


Role Variables
--------------

You will need to override many of the variables in `defaults/main.yml`, depending on your GPFS version.

- `gpfs_kernel_version`: Compile/install the GPFS module for this kernel version
- `gpfs_local_rpm_dir`: A local directory to which the extracted/built RPMs can be copied from the build node and subsequently deployed onto other nodes. For convenience this can be defined on the command line, e.g. `-e gpfs_local_rpm_dir=/tmp/gpfs-rpms`.
- `gpfs_package_source`: A local path or URL to the main GPFS package


Example Playbook
----------------



Additional Notes
----------------

- An earlier version of this role used parameters extensively for all versions.
However, the addition of the GPFS patch package complicates things since the names of packages aren't completely consistent, so it's easier to hardcode things.
- The GPFS patch requires some of the original installer packages to already be present, which adds to the complexity of this role.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
