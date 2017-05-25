# Local OpenStack setup

The main task is to create a Python virtualenv with all the needed
OpenStack modules and commands:

```sh
if [ -f ~/venv/openstack/bin/activate ]; then
    source ~/venv/openstack/bin/activate
else
    mkdir -p ~/venv
    virtualenv ~/venv/openstack
    source ~/venv/openstack/bin/activate

    pip install python-openstackclient
fi
```

And ansible:

```
pip install ansible
pip install 'pywinrm[credssp]'
```

Log into the OpenStack Horizon web interface and download the
configuration as `~/.openstackrc` (Compute»Access & Security»API
Access»Download OpenStack RC File v2.0).  Note "v3" configuration
files don't work at present for some reason.

```sh
source ~/.openstackrc
```

Set additional details required below (used in the other examples):

```sh
# SSH key name registered with OpenStack from "openstack keypair list"
ssh_key="your_ssh_key"
# Security group name from "openstack security group list"
security_group="required_security_group"
# SSH private key file for the above SSH key
ssh_private_key_file="/path/to/private/key"
```
