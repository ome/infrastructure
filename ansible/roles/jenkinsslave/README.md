Jenkins Slave
=============

Install the pre-requisites for a node to be setup as a Jenkins slave.

Role Variables
--------------

Defaults: `defaults/main.yml`

- `jenkinsuser`: The operating system user for the Jenkins slave
- `jenkinsworkdir`: The Jenkins work directory
- `authorized_key`: The Jenkins public ssh key
- `gitconfig.user`: Git email address
- `gitconfig.name`: Git full name
- `gitconfig.githubuser`: GitHub user
- `gitconfig.githubtoken`: GitHub token

- `spacewalk`: For internal OME use: Set to `True` if node is also maintained in spacewalk (this disables some operations), default False.

Dependencies
------------

Depends on the `java` role.

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
