#!/usr/bin/env bash
# Snapshot IDR volumes and instances

# Attempt to continue on error
#set -e
set -u

if [ $# -ne 1 ]; then
    echo "USAGE: $(basename "$0") vm_prefix"
    exit 1
fi

vm_prefix="$1"
today=$(date +%Y%m%d)
errors=0

for vm in \
        database \
        omero \
        proxy \
        a-dockermanager \
        management \
        ; do
    server="$vm_prefix-$vm"
    echo "Snapshotting server $server"
    openstack server image create --name "$server-$today" "$server" -f yaml
    [ $? -eq 0 ] || let errors++
    echo
done

for vol in \
        database-db \
        omero-data \
        proxy-nginxcache \
        a-dockermanager-jupyter \
        ; do
    volume="$vm_prefix-$vol"
    echo "Snapshotting volume $volume"
    openstack snapshot create --force --name "$volume-$today" "$volume" -f yaml
    [ $? -eq 0 ] || let errors++
    echo
done

if [ $errors -ne 0 ]; then
    echo "ERROR: $errors snapshots failed"
    exit $errors
fi
