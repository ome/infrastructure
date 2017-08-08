Server-state playbooks
----------------------

These playbooks encapsulate the running of various
production servers run by the OME team. The initial
template for these playbooks is now contained in:

  https://github.com/openmicroscopy/ansible-public-omero-example


Details
-------

- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- to install e.g. OMERO, or OMERO.web, and configure
  the server, depending on the requirements of that system,
    ansible-playbook playbook.yml
