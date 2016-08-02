Useful GPFS notes
=================

This is a summary of some useful GPFS concepts and commands.
Before doing any administrative work on a GPFS system you should consult the official docs.
- http://www.ibm.com/support/knowledgecenter/STXKQY/ibmspectrumscale_welcome.html

Some commands can be run as root from any node in the GPFS cluster including clients.
Depending on how the cluster is configured some commands can only be run from a limited number of administrative nodes.


Adding a node to a GPFS cluster
-------------------------------

Install the GPFS packages on the new node, for example using the [`gpfs` Ansible role](/ansible/roles/gpfs/README.md) in this repository.
You can then manually add the node to the GPFS cluster using these instructions as a guide.

First log into a root shell on one of the GPFS admin nodes.
Commands will be sent from the admin nodes to the other cluster nodes, this is why password-less ssh root access is required.

1. Check you can ssh as root without a password into the new node
2. Check the reverse IP of the new node matches it's hostname
3. Run `mmaddnode -N new.node.hostname` to add the node
4. Run `mmchlicense {client|server} --accept -N new.node.hostname` to assign a license
5. Run `mmlscluster` and `mmlslicense` to check the cluster
6. Run `mmstartup -N new.node.hostname` to start GPFS on the new node
7. Wait a few minutes for the node to initialise. GPFS may be mounted automatically in which case you do not need to do anything, otherwise run `mmmount filesystem-name -N new.node.hostname` to enable the mount on the new node (this will automatically add an entry to `/etc/fstab`)
8. You can check the state of all nodes by running `mmgetstate -a`

Note do not edit `/etc/fstab` directly (it is managed centrally by GPFS).


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

To delete a fileset:

    mmunlinkfileset gpfs-1 downloads
    mmdelfileset gpfs-1 downloads

If the fileset was not empty pass `-f` to `mmdelfileset`.


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
