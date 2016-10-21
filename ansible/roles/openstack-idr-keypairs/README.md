Openstack IDR Keypairs
======================

Uploads key-pairs for the provisioning of Openstack VMs in the IDR.

This combines keys to allow multiple users to login as the default account.
This should be for the initial provisioning only, once a VM goes into production individual user accounts with `sudo` rights should be created, and the default account should be locked down.


Role Variables
--------------

Required variables:
- `idr_keypair_keys`: A list of public SSH keys

Optional variables:
- `idr_keypair_name`: Name of the keypair, default `idr-deployment-key`


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
