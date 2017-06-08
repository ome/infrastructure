### This OME Demo Server playbook is based on a combination of our latest
### production OMERO.server and OMERO.web 'state playbooks'. 
###   https://github.com/openmicroscopy/infrastructure/tree/master/ansible/server-state-playbooks/nightshade-web 
###   https://github.com/openmicroscopy/infrastructure/tree/master/ansible/server-state-playbooks/ome-dundeeomero

### ansible playbooks & requirements for installing OME OMERO demo server.

- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install OMERO server
    ansible-playbook playbook.yml
