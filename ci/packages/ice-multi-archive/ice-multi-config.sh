#!/bin/bash
#
# eval this file in bash, and provide arguments to set the environment
# variables for building or running omero.
#
# Change BASEDIR if the ice packages have been installed somewhere else.
#
# Example:
#   $ eval $(~/ice/ice-multi-config.sh ice34)
#   $ echo $ICE_HOME
#   $ echo $PYTHONPATH
#   $ echo $PATH
#   $ echo $LD_LIBRARY_PATH
#   Build/run an ice34 version of OMERO

set -e

BASEDIR=$HOME/ice

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
        ice33 )
	    _ICE_HOME=$BASEDIR/ice-3.3.1
            ;;

        ice34 )
	    _ICE_HOME=$BASEDIR/ice-3.4.2
            ;;

        ice35 )
	    _ICE_HOME=$BASEDIR/ice-3.5.0
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
