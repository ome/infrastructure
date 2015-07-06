#!/bin/bash

set -eux
set -o pipefail

extract_ice_rpms()
{
    DIR=`basename $1`
    mkdir $DIR
    pushd $DIR
    for rpm in ../$1/*.rpm; do
        rpm2cpio $rpm | cpio -ivd
    done

    # Symlink directories so that everything has a standard layout
    ln -s usr/bin usr/include usr/lib64 .
    ln -s usr/share/Ice-*/slice .
    ln -s usr/lib64/python2.6/site-packages/Ice python
    popd
}

pip_install_local()
{
    pushd ice-$1
    PYTHONUSERBASE=$PWD/usr pip install --user zeroc-ice==$1
    rm python
    ln -s lib/python2.6/site-packages python
    popd
}

mkdir ice-rpms
pushd ice-rpms

# Glencoe ice-3.3.1 RPMS
wget --accept rpm --recursive --level=1 --no-parent --no-directories \
    --directory-prefix ice-3.3.1 \
    http://yum.glencoesoftware.com/zeroc-ice/6/x86_64/
wget --accept rpm --recursive --level=1 --no-parent --no-directories \
    --directory-prefix ice-3.3.1 \
    http://yum.glencoesoftware.com/zeroc-ice/6/noarch/

# Zeroc ice-3.4.2 RPMS
wget http://www.zeroc.com/download/Ice/3.4/Ice-3.4.2-rhel6-x86_64-rpm.tar.gz
mkdir ice-3.4.2
tar -C ice-3.4.2 -zxvf Ice-3.4.2-rhel6-x86_64-rpm.tar.gz

# Zeroc ice-3.5.0 RPMS
wget http://www.zeroc.com/download/Ice/3.5/Ice-3.5.0-el6-x86_64-rpm.tar.gz
mkdir ice-3.5.0
tar -C ice-3.5.0 -zxvf Ice-3.5.0-el6-x86_64-rpm.tar.gz

# Zeroc ice-3.5.1 RPMS
wget http://www.zeroc.com/download/Ice/3.5/Ice-3.5.1-el6-x86_64-rpm.tar.gz
mkdir ice-3.5.1
tar -C ice-3.5.1 -zxvf Ice-3.5.1-el6-x86_64-rpm.tar.gz

# Zeroc ice-3.6.0 RPMS
wget -nd -P ice-3.6.0 -r -np -l1 -A rpm https://zeroc.com/download/rpm/el6/noarch https://zeroc.com/download/rpm/el6/x86_64
popd

mkdir ice
pushd ice

for d in ../ice-rpms/ice-*/; do
    extract_ice_rpms $d
done

# ice-3.6.0 requires python to be installed using pip
for v in 3.6.0; do
    pip_install_local $v
done

cp ../ice-multi-config.sh ../test-ice-multi-config.sh .
popd

# Use tar because it's easier to handle symlinks
tar -zcvf centos6-ice-multi.tar.gz ice

# Self test
ice/test-ice-multi-config.sh
