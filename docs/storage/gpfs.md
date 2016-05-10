Useful GPFS notes
=================

This is a summary of some useful GPFS concepts and commands.
Before doing any administrative work on a GPFS system you should consult the official docs.
- http://www.ibm.com/support/knowledgecenter/STXKQY/ibmspectrumscale_welcome.html

Some commands can be run as root from any node in the GPFS cluster including clients.
Depending on how the cluster is configured some commands can only be run from a limited number of administrative nodes.


GPFS Filesets
-------------

A GPFS fileset is a subtree of a GPFS file-system that can be managed separately.
For example, policies can be set so that data is only stored on a subset of disks for performance, and (read-only) snapshots can be created of the subtree.
If you want to use snaphots you must create the fileset with the `--inode-space new` parameter, and you may want to specify the maximum number of inodes using `‐‐inode‐limit MaxNumInodes`.
A larger number of inodes requires more metadata space, so it should not be too large.
- http://www.ibm.com/support/knowledgecenter/STXKQY_4.1.1/com.ibm.spectrum.scale.v4r11.adv.doc/bl1adv_filesets.htm

For example, if you have a GPFS filesystem called `gpfs-1` mounted on `/data` and you want to create a new fileset called `downloads` with an initial maximum of 100k inodes:

    mmcrfileset gpfs-1 downloads --inode-space new ‐‐inode‐limit 100k
    mmlinkfileset gpfs-1 downloads -J /data/downloads

You can increase the maximum number of inodes after creating the fileset:

    mmchfileset gpfs-1 downloads ‐‐inode‐limit 1m

Note it is not possible to convert an existing directory into a fileset.

To list existing filesets:

    mmlsfileset gpfs-1

Add `-L` to see additional information include any inode limits.


GPFS Snapshots
--------------

GPFS snapshots are **read-only** snapshots of either the entire GPFS filesystem, or a single fileset.
They are useful for taking consistent backups of an subtree, or for tagging versions of a directory for future reference.
GPFS uses a form of copy-on-write so is not the same as a backup.
- http://www.ibm.com/support/knowledgecenter/STXKQY_4.1.1/com.ibm.spectrum.scale.v4r11.adv.doc/bl1adv_logcopy.htm
- http://www.ibm.com/support/knowledgecenter/STXKQY_4.1.1/com.ibm.spectrum.scale.v4r11.adv.doc/bl1adv_fslevelsnaps.htm%23bl1adv_fslevelsnaps

To create a snapshot of the `downloads` fileset called `downloads-0.1`:

    mmcrsnapshot gpfs-1 downloads-0.1 -j downloads

To list all snapshots:

    mmlssnapshot gpfs-1

To delete a snapshot:

    mmdelsnapshot gpfs-1 downloads-0.1 -j downloads
