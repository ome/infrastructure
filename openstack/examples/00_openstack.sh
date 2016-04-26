#!/bin/bash

# This script is not needed under docker.

## Mount network shares
SMB_USER=username
SMB_SHARE1=//orca-5.openmicroscopy.org/idr
sudo mkdir -p /uod/idr
sudo mount -t cifs -o username="$SMB_USER" "$SMB_SHARE1" /uod/idr

if [ ! -d /uod/idr/filesets ]; then
    echo "ERROR: IDR filesets not found, exiting"
    exit 2
fi

# Optionally disable autostart of OMERO.server
# because /uod/idr needs to be manually mounted
sudo systemctl disable omero

# If there are web css problems you may need to restore the SELinux labelling
sudo restorecon -R -v ~omero/
