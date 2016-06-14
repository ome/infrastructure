Scripts for snapshotting IDR OpenStack volumes
==============================================

The process of snapshotting multiple volumes and
migrating them between clouds is non-trivial.

Scripts for doing so are provided here.

For steps 2-4 you should `source settings.env`, optionally setting the `PREFIX` and `DATE` environment variables as required.

1. os-idr-snapshot.sh   - Snapshot the instances.
                          Requires `vm_prefix` as the first argument.
                          You must wait for the statuses of the snapshots to change from `creating` to `available` before continuing
2. os-idr-mkvol.sh      - Convert the snapshots into volumes.
                          Wait for the status to change to `available`.
3. os-idr-mkimg.sh      - Convert the volumes into images.
4. os-idr-download.sh   - Download the images locally.
5. os-idr-upload.sh     - Upload the images to a new cloud.
                          Be sure to source a second openrc file.

Todos
-----

These scripts will attempt to wait for the background openstack processes to finish.
However they do not distinguish between operations performed by this script and those performed by others, so for instance if someone else is creating volumes or images these scripts will wait for all tasks to complete, not just your own.
