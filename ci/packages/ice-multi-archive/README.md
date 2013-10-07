Run `create_ice_multi_zip.sh` to build an archive containing multiple
Ice versions for deployment on an OME Centos6 CI node.

To deploy:

    $ cd $HOME
    $ tar -zxvf centos6-ice-multi.tar.gz

To set the environment for building/running OMERO

    $ eval $(~/ice/ice-multi-config.sh ice342)

    $ echo $ICE_HOME
    $ echo $PYTHONPATH
    $ echo $PATH
    $ echo $LD_LIBRARY_PATH

See `ice-multi-config.sh` for other versions.

