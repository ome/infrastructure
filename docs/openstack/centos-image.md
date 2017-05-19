# CentOS OpenStack image creation

OpenStack images for CentOS are available from
[cloud.centos.org](https://cloud.centos.org), including
current images for:

- [CentOS 6](https://cloud.centos.org/centos/6/images/CentOS-6-x86_64-GenericCloud.qcow2.xz)
- [CentOS 7](https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2.xz)

Follow the [local setup](local-setup.md) instructions before starting.

## Image creation

Download image from the above URL, then run:

```sh
openstack image create --file ~/Downloads/CentOS-6-x86_64-GenericCloud.qcow2 --disk-format qcow2 --container-format bare "CentOS 6"
openstack image create --file ~/Downloads/CentOS-7-x86_64-GenericCloud.qcow2 --disk-format qcow2 --container-format bare "CentOS 7"
```
