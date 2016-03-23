# Using OpenStack

The easiest way to start using OpenStack is through the Horizon web interface.


## Running an image

Login and select `Project > Compute`:

Open `Access and Security` in the left hand menu.
OpenStack requires ports to be explicitly opened for all VMs.
The `default` security group allows all network traffic between VMs in the private network.
If there are no other groups:

    1. Click `Create Security Group`
    2. Give it a name, e.g. `ssh`, then click `Create Security Group`
    3. Click `Manage Rules` for the newly created group
    4. `Add Rule`
    5. You can select a predefined rule such as `SSH`, or choose a custom one.
    6. Enter a `CIDR` if necessary
    7. Click `Add`
    8. You can add additional rules if you wish

Open `Images` in the left hand menu.
You should see `Cirros 0.3.4` listed.

Open `Instances` in the left hand menu:

    1. Click `Launch instance`
    2. Under `Details`:
        - `Instance Name`: give the VM a name
        - `Flavor`: select from predefined combinations of CPU, memory
        - `Instance Boot Source`: Either select `Boot from image`, or `Boot from image (creates a new volume)`, the latter will create a new volume on shared storage instead of a local VM image and will also allow you to customise the allocated disk space
        - `Image Name`: Select the base image for the VM, e.g. `Cirros 0.3.4`
        - If you're opted to create a new volume select the disk size
    3. Under `Access & Security`:
        - `Key Pair`: Many linux cloud images allow initial remote access via SSH keys. If you haven't already created a key click `+`, give it a recognisable name, paste your SSH public key into `Public Key`, and click `Import Key Pair`.
        - Alternatively you can go back to the `Access and Security` tab in the left hand menu and get OpenStack to generate a new key pair for you.
        - `Security Groups`: Choose the security group(s) controlling access to your VM, e.g. `ssh`
    4. Under `Networking`: Click `+` on a network (e.g. `private_network`). If `external_network` is shown ignore it unless you decided to give all users access to that network when configuring OpenStack networking.
    5. Click `Launch`
    6. When the VM is created and running click on the down arrow next to the VM and select `Associate Floating IP`. Floating IPs are IPs on the external network that can be kept even after a VM is terminated.
        - `IP Address`: Either select an existing, or click `+`. There should only be a single `Pool` (`external_network`) so just click `Allocate IP`.
        - `Port to be associated`: this should default to the VM's existing network interface.
        - Click `Associate`
    7. You may need to refresh the `Instances` view, after which you should see the `Floating IP` allocated to your VM.

You can also create and manage VMs from the command-line using `nova`.


## Connecting to the VM

If you have setup your SSH keys, access/security rules and floating IP correctly you should be able to ssh into your newly created VM remotely without a password:

    ssh username@FLOATING_IP

Where username is the the preconfigured account on the base image, see the documentation for the image. For example:

    ssh cirros@FLOATING_IP_1
    ssh centos@FLOATING_IP_2

Most images should be configured with password-less `sudo`.

You can also access a virtual console for each VM.

    1. Open the `Instances` view
    2. Click on the `Instance Name`
    3. You should be taken to the `Instance Details` page, click on `Console`
    4. You should see a virtual console, if not click on `Click here to show only console`


# Adding more images

If OpenStack is using GPFS as a backing store using raw images will enable it to take advantage of GPFS copy-on-write, otherwise qcow2 is recommended.
Use `qemu-img convert` if necessary.

Either add images in Horizon, or use the command line.
For example, to add the latest CentOS image (7.2):

    curl http://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1602.raw.tar.gz > CentOS-7-x86_64-GenericCloud-1602.raw.tar.gz
    tar -zxf CentOS-7-x86_64-GenericCloud-1602.raw.tar.gz
    glance image-create --name='CentOS 7.2 1602' --visibility public --container-format=bare --disk-format=raw < CentOS-7-x86_64-GenericCloud-20160221_01.raw

A list of popular images can be found at http://docs.openstack.org/image-guide/obtain-images.html.
You can download an evaluation version of Windows from https://cloudbase.it/windows-cloud-images/. Alternatively use [Cloudbase-init](https://cloudbase.it/cloudbase-init/) to create your own image from a Windows iso.


## Command line API

An alternative to the Horizon web interface are the OpenStack command line clients, which allow all aspects of OpenStack to be controlled remotely:

    pip install python-openstackclient

This will install the latest OpenStack clients, which may be different from those installed on the OpenStack servers.
In particular, many of the separate clients (e.g. `neutron` for managing networks) have been combined into one program.
The main clients are:

- `cinder`: Manage storage volumes
- `glance`: Manage images
- `nova`: Start, stop and manage VMs
- `openstack`: Multi-function client (includes networking)

See http://docs.openstack.org/cli-reference/common/cli_install_openstack_command_line_clients.html for more details, and http://docs.openstack.org/user-guide/cli_cheat_sheet.html for a cheat sheet.

These commands all require remote login credentials, which can be specified as environment variables (easiest), command line arguments or interactively.
You can download an environment settings file from Horizon:

    1. Login as the user you will be using for command line access
    2. Select `Project > Compute > Access and Security`
    3. Open the `API Access` tab
    4. Click on `Download OpenStack RC File`

Source this file in your shell before running any of the OpenStack clients.

Many of the `neutron` commands can be replaced by `openstack` commands fairly simply, for example:
- `neutron net-list`: `openstack network list`
- `neutron subnet-list`: `openstack subnet list`
- `neutron security-group-create ...`: `openstack security group create ...`

If you want to use the original `neutron` command for managing networks install it:

    pip install python-neutronclient

To start a VM using `nova`:

    nova boot --image "Cirros 0.3.4" --flavor m1.tiny \
        --security-groups default,ssh --key-name "$SSH_KEY_NAME" test-vm
    nova floating-ip-associate test-vm $FLOATING_IP
    # ssh cirros@$FLOATING_IP
    nova delete test-vm
    nova list

To start a VM backed by a volume:

    nova boot --image "CentOS 7.2 1602" --flavor m1.medium \
        --security-groups all --key-name "$SSH_KEY_NAME" \
        --block-device id=$IMAGE_UUID,source=image,size=$SIZE_IN_GB test-vm
