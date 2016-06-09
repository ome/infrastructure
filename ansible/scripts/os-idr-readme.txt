The process of snapshotting multiple volumes and
migrating them between clouds is non-trivial.

Scripts for doing so are provided here.

1. os-idr-snapshot.sh   - Snapshot the instances.
2. os-idr-mkvol.sh      - Convert the snapshots into volumes.
3. os-idr-mkimg.sh      - Convert the volumes into images.
4. os-idr-download.sh   - Download the images locally.
5. os-idr-upload.sh     - Upload the images to a new cloud.
                          Be sure to source a second openrc file.
