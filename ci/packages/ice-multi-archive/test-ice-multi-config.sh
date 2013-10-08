#!/bin/bash

set -eu

export ICE_BASEDIR=`dirname $0`

failed()
{
	echo "FAILED: $1"
	exit 1
}

test_ice_version()
{
	echo Checking $1 $2
	eval $($ICE_BASEDIR/ice-multi-config.sh $1) || \
		failed "Setting ice version"

	echo ICE_VERSION=$ICE_VERSION
	echo ICE_HOME=$ICE_HOME
	echo PYTHONPATH=$PYTHONPATH
	echo PATH=$PATH
	echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH
	echo LIBPATH=$LIBPATH

	test "`icegridadmin --version`" = $2 || \
		failed "icegridadmin version is incorrect"
	python -c "import Ice, sys; sys.exit(0 if Ice.__file__.endswith('ice-$2/python/Ice.py') or Ice.__file__.endswith('ice-$2/python/Ice.pyc') else 1)" || \
		failed "python Ice version is incorrect"
	echo
}

echo ICE_BASEDIR=$ICE_BASEDIR

test_ice_version ice331 3.3.1
test_ice_version ice342 3.4.2
test_ice_version ice350 3.5.0
test_ice_version ice351 3.5.1

test_ice_version ice33 3.3.1
test_ice_version ice34 3.4.2
test_ice_version ice35 3.5.0

