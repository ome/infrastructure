Server-state playbooks
----------------------

These playbooks encapsulate the running of various
production servers run by the OME team. The initial
template for these playbooks are now contained in:

  https://github.com/openmicroscopy/ansible-public-omero-example


Details
-------

- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install OMERO.web server
    ansible-playbook playbook.yml
