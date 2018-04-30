# Ubuntu OpenStack image creation

OpenStack images for Ubuntu are available from
[cloudbase.it](https://cloud-images.ubuntu.com/), including
images for:

- [Ubuntu 16.04](https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img)
- [Ubuntu 18.04](https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img)

Follow the [local setup](local-setup.md) instructions before starting.

## Image creation

Download image from the above URL, then run:

```sh
openstack image create --file xenial-server-cloudimg-amd64-disk1.img --disk-format qcow2 "Ubuntu 16.04"
openstack image create --file bionic-server-cloudimg-amd64.img --disk-format qcow2 "Ubuntu 18.04"
```
