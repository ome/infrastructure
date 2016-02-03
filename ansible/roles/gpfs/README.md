GPFS
====

Extract GPFS RPMs from their distributed package and build a kernel module RPM.
Setup a GPFS client.

Work in progress.


Requirements
------------

Ensure all packages are updated. The GPFS kernel module will be compiled for the kernel running on the machine.


Role Variables
--------------

You will need to override many of the variables in `defaults/main.yml`, depending on your GPFS version.

- `gpfs_kernel_version`: Compile/install the GPFS module for this kernel version
- `gpfs_local_rpm_dir`: A local directory to which the extracted/built RPMs can be copied from the build node and subsequently deployed onto other nodes. For convenience this can be defined on the command line, e.g. `-e gpfs_local_rpm_dir=/tmp/gpfs-rpms`.
- `gpfs_package_source`: A local path or URL to the main GPFS package


Example Playbook
----------------


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
