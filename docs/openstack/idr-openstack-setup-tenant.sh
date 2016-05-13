#!/bin/sh
# Setup default networks and security groups for an OpenStack tenant

set -eu

TENANT=${1:-}
SUBNET=${2:-}
DNS1=${3:-}
DNS2=${4:-}
if [ -z "$TENANT" -o -z "$SUBNET" -o -z "$DNS1" ]; then
    echo "ERROR: Usage: `basename $0` NEW-TENANT SUBNET DNS1 [DNS2]"
    echo "  E.g. `basename $0` new-tenant 192.168.1.0/24 8.8.4.4 8.8.8.8"
    exit 2
fi

DNS="--dns-nameserver $DNS1"
if [ -n "$DNS2" ]; then
    DNS="$DNS --dns-nameserver $DNS2"
fi

# Create a private network

neutron net-create ${TENANT}_network
neutron subnet-create --name ${TENANT}_subnet ${TENANT}_network ${SUBNET} ${DNS}

# Create a router to connect the external and private networks

neutron router-create ${TENANT}_router
neutron router-gateway-set ${TENANT}_router external_network
neutron router-interface-add ${TENANT}_router ${TENANT}_subnet

# Create some security groups

nova secgroup-create ssh "SSH from anywhere"
nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0

nova secgroup-create all "TCP/UDP/ICMP from anywhere"
nova secgroup-add-rule all tcp 1 65535 0.0.0.0/0
nova secgroup-add-rule all udp 1 65535 0.0.0.0/0
nova secgroup-add-rule all icmp -1 -1 0.0.0.0/0
