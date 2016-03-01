# OpenStack installation

These instructions are designed for a proof-of-concept installation.
They were last tested with OpenStack Liberty, February 2016:

    $ packstack --version
    packstack Liberty 7.0.0.dev1682.g42b3426


## Installation of first all-in-one node

Run `idr-openstack-pre.yml` and any other playbooks required for setting up the system such as `idr-gpfs-client.yml` (it should not be necessary to run `idr-initial.yml`).
If you are modifying the network configuration use `pre_network_ifaces` instead of `network_ifaces` (this is because the network will be reconfigured later, and by not using `network_ifaces` it can be assigned separately), for example:

    pre_network_ifaces:
    - device: eno1
      bootproto: static
      ip: 10.0.0.1
      prefix: 21
      gateway: 10.0.0.254
      dns1: 8.8.4.4
      dns2: 8.8.8.8

Reboot the system to ensure everything is up-to-date.

Log in as a normal user (you do not need to be `root`).

Setup ssh keys so `ssh root@localhost` works without a password (you may wish to delete these keys later):

    ssh-keygen
    sudo sh -c "cat $HOME/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys"

The general plan:

1. Create a near-default allinone setup
2. Reconfigure Cinder to use gpfs instead of a loopback device
3. Configure external network bridge and virtual networks
4. Add additional nodes

Create a single-node allinone setup, excluding external network configuration and (optionally) without swift object storage.
Enable self-signed SSL for the Horizon web interface so that it's easy to modify with real SSL certificates:

    packstack --allinone --os-horizon-ssl=y --os-swift-install=n --provision-demo=n

If you are using a different backend such as NFS this can be enabled using additional arguments.

This will take a while to run.
Packstack uses Puppet to deploy OpenStack, so can be run multiple times during installation using the generated answers file.
However it may revert any manual configuration changes so take care before running this on an operational OpenStack instance:

    packstack --answer-file packstack-answers-YYYYMMDD-hhmmss.txt

When packstack has finished there should be a `keystonerc_admin` file containing the login details for the OpenStack admin account.


# Configuration

OpenStack installs the `crudini` utility which can be used to edit ini files.


## GPFS configuration

See http://docs.openstack.org/liberty/config-reference/content/GPFS-driver-options.html for the full list of options.

Create a directory for the Cinder volumes and images (as root):

    OS_GPFS=/gpfs/openstack
    mkdir -p $OS_GPFS/{block,images}

Reconfigure Cinder to use GPFS (as root):

    CINDER_CONF=/etc/cinder/cinder.conf
    cp $CINDER_CONF $CINDER_CONF.bak

    crudini --set $CINDER_CONF DEFAULT enabled_backends gpfs

    crudini --set $CINDER_CONF gpfs gpfs_images_dir $OS_GPFS/images
    crudini --set $CINDER_CONF gpfs gpfs_images_share_mode copy_on_write
    crudini --set $CINDER_CONF gpfs gpfs_mount_point_base $OS_GPFS/block
    crudini --set $CINDER_CONF gpfs gpfs_sparse_volumes True
    crudini --set $CINDER_CONF gpfs volume_driver cinder.volume.drivers.ibm.gpfs.GPFSDriver

Optionally set an alternative storage pool:

    crudini --set $CINDER_CONF gpfs gpfs_storage_pool system

The current version of packstack has a bug https://bugzilla.redhat.com/show_bug.cgi?id=1272572, workaround it:

    crudini --set $CINDER_CONF keystone_authtoken auth_uri http://localhost:5000/

Restart Cinder:

    systemctl restart openstack-cinder-api
    systemctl restart openstack-cinder-scheduler
    systemctl restart openstack-cinder-volume

Configure the Glance image service to use GPFS:

    crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir $OS_GPFS/images
    chown glance:glance $OS_GPFS/images
    systemctl restart openstack-glance-api


## Create external network

This will allow OpenStack to use the existing network.
See https://www.rdoproject.org/networking/neutron-with-existing-external-network/ for additional information.
The following steps must be performed as root.

The external network interface must be reconfigured as an OpenSwitch bridge.
For example, if the existing interface is called `eno1` and the IP of the current node is 10.0.01/24 you can use the `network` role to add a bridge, in this example called `br-ex` using the `idr-openstack-post.yml` playbook:

    post_network_ifaces:
    - device: eno1
      devicetype: ovs
      type: OVSPort
      ovsbridge: br-ex
    - device: br-ex
      bootproto: static
      ip: 10.0.0.1
      prefix: 21
      devicetype: ovs
      type: OVSBridge
      gateway: 10.0.0.254
      dns1: 8.8.4.4
      dns2: 8.8.8.8

Restart the network (if the network isn't reconfigured you may need to reboot):

    systemctl restart network

Give an internal OpenStack name to the newly created bridge such as `extnet`, and enable other network types:

    crudini --set /etc/neutron/plugins/ml2/openvswitch_agent.ini ovs bridge_mappings extnet:br-ex
    crudini --set /etc/neutron/plugin.ini ml2 type_drivers vxlan,flat,vlan

Restart Neutron networking services:

    systemctl restart neutron-openvswitch-agent
    systemctl restart neutron-server


## Openstack virtual networking setup

The following steps will setup the OpenStack virtual networks that will allow VMs to connect with the outside network.
This will create a default OpenStack topology in which VMs have to be explicitly assigned a floating IP to allow incoming connections.
VMs are normally assigned an IP by the OpenStack DHCP server, and the advantage of using separate floating IPs is that they can be maintained and reassigned to different VMs regardless of the internal address given to the VM.

The following commands should be run as a normal user (alternatively everything can be done through the Horizon web interface).
First source the admin login credentials for the OpenStack API:

    source keystonerc_admin

Create the OpenStack external network, where `extnet` is the name used in the previous section.

    neutron net-create external_network --provider:network_type flat --provider:physical_network extnet --router:external

Create a subnet within this network.
`gateway` and `external_network` should be the gateway and CIDR matching the physical interface `br-ex`, and the `allocation-pool` should be an unused range of IP addresses that OpenStack can assign to VMs:

    neutron subnet-create --name public_subnet --enable_dhcp=False --allocation-pool=start=10.0.0.64,end=10.0.0.127 --gateway=10.0.0.254 external_network 10.0.0.0/24

* If you want all users to have direct access to the external network, and you would like to assign IPs from the external network directly to VMs instead of using floating IPs, modify the previous commands with `--shared` and`--enable_dhcp=True`:

      neutron net-create external_network --provider:network_type flat --provider:physical_network extnet --router:external --shared
      neutron subnet-create --name public_subnet --enable_dhcp=True --allocation-pool=start=10.0.0.64,end=10.0.0.127 --gateway=10.0.0.254 external_network 10.0.0.0/24

Create a private network and subnet:

    neutron net-create private_network
    neutron subnet-create --name private_subnet private_network 192.168.100.0/24 --dns-nameserver 8.8.4.4 --dns-nameserver 8.8.8.8

Create a router to connect the external and private networks:

    neutron router-create router1
    neutron router-gateway-set router1 external_network
    neutron router-interface-add router1 private_subnet


# Testing the installation so far

At this point it is advisable to check everything is working before continuing.


## Adding an image

OpenStack with KVM/qemu normally works with the qcow2 format, which is designed to support copy-on-write.
However, if OpenStack Cinder is using the GPFS driver copy-on-write can be handled by the file system, so for best performance you should use raw images.

You can either use the Horizon web dashboard, or the command line.
To download the Cirros test image (qcow2), convert it to raw, and upload it to OpenStack:

    curl http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img > cirros-0.3.4-x86_64-disk.img
    qemu-img convert -f qcow2 -O raw cirros-0.3.4-x86_64-disk.img cirros-0.3.4-x86_64-disk.raw
    glance image-create --name='Cirros 0.3.4' --visibility public --container-format=bare --disk-format=raw < cirros-0.3.4-x86_64-disk.raw

You can also add images using the Horizon web interface.

Then follow the instructions in [idr-openstack-using.md](idr-openstack-using.md) to start and connect to the VM, using the username and password from the `keystonerc_admin` file.


# Customising flavours

A flavour is a preset combination of COUs, memory and ephemeral disk.
You can add or modify the defaults in Horizon (`System > Flavors`), or on the command line.
For instance, to replace all the default flavours:

    nova flavor-delete m1.tiny
    nova flavor-delete m1.small
    nova flavor-delete m1.medium
    nova flavor-delete m1.large
    nova flavor-delete m1.xlarge

    nova flavor-create m1.tiny 1 1024 5 1
    nova flavor-create m1.small 2 2048 10 2
    nova flavor-create m1.medium 3 4096 20 4
    nova flavor-create m1.large 4 8192 20 8
    nova flavor-create m1.xlarge 5 16384 20 16

# Adding more nodes

See https://www.rdoproject.org/install/adding-a-compute-node/ for more details.
As a normal user copy the packstack answer file created by the last run if packstack, and modify it to append the new nodes (do not remove the existing nodes).
Add the current node to the exclusions to ensure it's configuration is not modified.
For example, to add two new nodes, 10.0.0.2 and 10.0.0.3 without changing the current node (10.0.0.1):

    cp packstack-answers-YYYYMMDD-hhmmss.txt packstack-answers-new.txt
    PACKSTACK_ANSWERS=packstack-answers-new.txt
    crudini --set $PACKSTACK_ANSWERS general CONFIG_COMPUTE_HOSTS 10.0.0.1,10.0.0.2,10.0.0.3
    crudini --set $PACKSTACK_ANSWERS general CONFIG_NETWORK_HOSTS 10.0.0.1,10.0.0.2,10.0.0.3
    crudini --set $PACKSTACK_ANSWERS general EXCLUDE_SERVERS 10.0.0.1

As before you will need to setup `ssh root@new-node`.
Once this is done run packstack again from the current node as a normal user.

    packstack --answer-file $PACKSTACK_ANSWERS

You will need to reconfigure the physical network interface to match that of the original node (e.g. create bridge `br-ex` using `eno1`).
It should not be necessary to make any other changes (for example, it is not necessary to run the neutron configuration steps again since it is a virtual network).


# Adding projects/tenancies and users

Initially there should be `admin` and `services` projects (also known as tenancies).
- `admin`: Amongst other things this can be used for setting up shared infrastructure such as networks or images that can't be modified by other tenants
- `services`: Internal OpenStack use only, if you touch this you will probably break something.

If you go to `Identity` in the left hand Horizon menu you can manage `Projects` and `Users`.
Alternatively you can use the command line.

For instance, to create a project called `omedev` with a single user `test` and password `abc123`:

    source keystonerc_admin
    NEW_TENANT=omedev
    NEW_USER=test
    NEW_PASSWORD=abc123
    keystone tenant-create --name $NEW_TENANT --description "Developers" --enabled true
    keystone user-create --name $NEW_USER --tenant $NEW_TENANT --pass "$NEW_PASSWORD" --email developers@example.org --enabled true

Once you have created the tenant you will need to create a network and attach it to the external network, either in Horizon or using the command line clients.
Note that this private network can have the same CIDR as another tenant's network, since they are completely separate.

Login to Horizon and create the network, subnet, router, and optionally some security groups.
Alternatively use the command line.
Copy and modify the `keystonerc_admin` file, or login to Horizon as a user of the new tenancy and download an environment settings file (`Project > Compute > Access and Security > API Access > Download OpenStack RC File`):

    source keystonerc_$NEW_TENANT
    neutron net-create ${NEW_TENANT}_network
    neutron subnet-create --name private_subnet ${NEW_TENANT}_network 192.168.1.0/24 --dns-nameserver 8.8.4.4 --dns-nameserver 8.8.8.8

Create a router to connect the external and private networks:

    neutron router-create ${NEW_TENANT}_router
    neutron router-gateway-set ${NEW_TENANT}_router external_network
    neutron router-interface-add ${NEW_TENANT}_router ${NEW_TENANT}_subnet

Create some security groups:

    nova secgroup-create ssh "SSH from anywhere"
    nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0

    nova secgroup-create all "TCP/UDP/ICMP from anywhere"
    nova secgroup-add-rule all tcp 1 65535 0.0.0.0/0
    nova secgroup-add-rule all udp 1 65535 0.0.0.0/0
    nova secgroup-add-rule all icmp -1 -1 0.0.0.0/0

If you want to set quotas for a tenant/project login to Horizon as an admin and go to `Identity > Projects`, in the dropdown to the right of the project click `Modify Quotas`.


# Configuring https for Horizon and online consoles

Packstack will setup Horizon to use a self-signed certificate.
To change the certificate used for the online console log into the controller node (e.g. 10.0.0.1):

    crudini --set /etc/nova/nova.conf DEFAULT cert /etc/pki/tls/certs/openstack.crt
    crudini --set /etc/nova/nova.conf DEFAULT key /etc/pki/tls/private/openstack.key
    systemctl restart openstack-nova-novncproxy

If you have a proper SSL certificate copy the certificate and key files to the server, and update the configuration.
You may also need to update the `ServerName` to match the certificate, for example:

    sed -i.bak -r \
        -e 's|(\s*ServerName\s+).+|\1server.host.name|' \
        -e 's|(\s*SSLCertificateFile\s+).+|\1"/etc/pki/tls/certs/openstack.crt"|' \
        -e 's|(\s*SSLCertificateKeyFile\s+).+|\1"/etc/pki/tls/private/openstack.key"|' \
        /etc/httpd/conf.d/15-horizon_ssl_vhost.conf
    systemctl restart httpd
