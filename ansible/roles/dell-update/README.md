Dell Update
===========

Run Dell Linux driver updates such as those for the BIOS and iDRAC.

Assumes the update package takes the following options (`--help`):

    Command-line options for the Update Package

    Usage: <package name> [options...]

    Options:

    -h,--help     : Display command-line usage help
    -c            : Determine if the update can be applied to the system (1)
    -f            : Force a downgrade to an older version. (1)(2)
    -q            : Execute the update package silently without user intervention
    -n            : Execute the update package without security verification
    -r            : Reboot if necessary after the update (2)
    -v,--version  : Display version information
    --list        : Display contents of package (3)
    --extract <path> : Extract files to specified path (3)(4)

The system will be automatically rebooted if necessary, however this role will not wait for it to come back up so you will see an error.

TODO: Wait for host to come back up after a reboot

Note: Update packages are run in non-interactive mode with automatic reboot if necessary (`-q -r`).
It is possible the package will reboot the server before installing the update, for example BIOS updates, in contrast to interactive mode where the command line remains connected until after the BIOS is updated.
Do not be unduly worried (unless the server remains inaccessible after several minutes in which case check the console).


Requirements
------------

Ensure the Dell update package is in the directory specified by `dell_update_package_dir`.


Role Variables
--------------

- `dell_update_package_dir`: The directory containing the update package, default `files`
- `dell_update_filename`: The filename of the update packaged, required


Example Playbook
----------------

    # Update the iDRAC and BIOS, the BIOS update requires a reboot so put it last
    - hosts: dell-servers
      roles:
      - role: dell-update
        dell_update_filename: iDRAC-with-Lifecycle-Controller_Firmware_5GCHC_LN_2.30.30.30_A00.BIN
      - role: dell-update
        dell_update_filename: BIOS_DC9XJ_LN_2.1.7.BIN



Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
