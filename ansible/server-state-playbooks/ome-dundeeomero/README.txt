### Taken from openmicroscopy/ansible-public-omero-example.git
### and stripped of web components, leaving just server.

### ansible playbooks & requirements for installing basic OMERO server.
### addition of NGINX to proxy to a decoupled remote OMERO.web server.


- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install OMERO server
    ansible-playbook playbook.yml
