# OME Infrastructure

Tools, scripts and other systems infrastructure used to support the work of OME (http://www.openmicroscopy.org/).

If you are interested in this work or require more information, please
[contact us](http://www.openmicroscopy.org/site/community).

[![Build Status](https://travis-ci.org/openmicroscopy/infrastructure.png)](http://travis-ci.org/openmicroscopy/infrastructure)

## Ansible

OME uses Ansible extensively for deploying production services. Installation and usage instructions are
provided in the [ansible README](ansible/README.md).

## OpenStack

- [Server setup](docs/openstack/idr-openstack.md) outlines the
  installation of OpenStack which is running at the University of
  Dundee.
- [Basic usage](docs/openstack/idr-openstack-using.md) outlines possible
  first steps.
- [Local setup](docs/openstack/local-setup.md) details the steps to
  access OpenStack from a client system
- [CentOS image creation](docs/openstack/centos-image.md)
- [FreeBSD image creation](docs/openstack/freebsd-image.md)
- [Ubuntu image creation](docs/openstack/ubuntu-image.md)
- [Windows image creation](docs/openstack/windows-image.md)
- [MacOS X image creation](docs/vmware/mac-image.md)
- [CI setup](docs/openstack/ci-setup.md) details the steps to
  set up a CI node

## GPFS

[GPFS.md](docs/storage/gpfs.md) provides details on the configuration of GPFS that is used
at the University of Dundee.

---------

For further information, you may want to read the
[Contributing to OME](https://www.openmicroscopy.org/site/support/contributing/) page.
