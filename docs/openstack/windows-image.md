# Windows OpenStack image creation

OpenStack images for Windows are available from
[cloudbase.it](https://cloudbase.it/windows-cloud-images/), including
images for [Windows Server
2012R2](https://cloudbase.it/openstack-windows-server-2012-r2-evalution-images/).

## Local setup

Create python virtualenv for openstack modules

```sh
if [ -f ~/venv/openstack/bin/activate ]; then
    source ~/venv/openstack/bin/activate
else
    mkdir -p ~/venv
    virtualenv ~/venv/openstack
    source ~/venv/openstack/bin/activate

    pip install python-openstackclient
fi

source ~/.openstackrc
```

Set additional details required below:

```sh
ssh_key="your_ssh_key"
security_group="required_security_group"
ssh_private_key_file="/path/to private key for ${ssh_key} name"
```

## Image creation

Download image from the above URL, then run:

```sh
openstack image create --file ~/Downloads/windows_server_2012_r2_standard_eval_kvm_20170321.qcow2 --disk-format bare --container-format qcow2 "Windows Server 2012R2"
```

## Test

List available networks:

```sh
openstack network list
```

Set `net_id` using `id` for required network (must permit outgoing
external connections for downloading packages).

Create a VM using our new image:

```sh
openstack server create --image="Windows Server 2012R2" --security-group "$security_group" --nic "net-id=$net_id" --key-name "$ssh_key" --flavor "m1.small"  "test7"
```

Set `test_vm_id` using `id` of created VM.

The Windows image requires the Admin password to be obtained:

```sh
nova get-password "$test_vm_id" | base64 -d | openssl rsautl -decrypt -inkey "$ssh_private_key_file"
```

It should now be possible to log on to the OpenStack console for this
VM using the username `Admin` and this password.  You can also use
PowerShell remoting (RMI) to administer the system with the same
credentials.
