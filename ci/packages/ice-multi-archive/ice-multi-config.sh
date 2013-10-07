#!/bin/bash
#
# eval this file in bash, and provide arguments to set the environment
# variables for building or running omero.
#
# Example: setup the environment for ice 3.4.2
#   $ eval $(~/ice/ice-multi-config.sh ice342)
#   $ echo $ICE_HOME
#   $ echo $PYTHONPATH
#   $ echo $PATH
#   $ echo $LD_LIBRARY_PATH
#

set -e

ICE_BASEDIR=`dirname $0`

prepend_path() {
    VAR="$1"
    PRE="$2"
    eval CURRENT="\\\"\$$VAR\\\""
    if [ "$CURRENT" != \"\" ]; then
        echo "CURRENT $VAR=$CURRENT"
        eval echo export "$VAR=\\\"$PRE:$CURRENT\\\""
    else
        echo export "$VAR=\"$PRE\""
    fi
}

omero_env() {
    case "$1" in
        ice33 | ice331 )
	    _ICE_HOME=$ICE_BASEDIR/ice-3.3.1
            ;;

        ice34 | ice342 )
	    _ICE_HOME=$ICE_BASEDIR/ice-3.4.2
            ;;

        ice35 | ice350 )
	    _ICE_HOME=$ICE_BASEDIR/ice-3.5.0
            ;;

        ice351 )
	    _ICE_HOME=$ICE_BASEDIR/ice-3.5.1
            ;;

        * )
            echo "ERROR: Unknown environment option: $1" >&2
            # This ensures the eval returns non-zero
            echo false
            exit 1
            ;;
    esac

    if [ -n "$_ICE_HOME" ]; then
        echo export ICE_HOME=\"$_ICE_HOME\"
        prepend_path PYTHONPATH "$_ICE_HOME/python"
        prepend_path PATH "$_ICE_HOME/bin"
        prepend_path LD_LIBRARY_PATH "$_ICE_HOME/lib64"
    fi

    return 0
}

while [ $# -gt 0 ]; do
    omero_env "$1"
    shift
done
