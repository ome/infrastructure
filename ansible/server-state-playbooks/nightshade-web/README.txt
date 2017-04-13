### Taken from manics/ansible-public-omero-example.git
### at bc730e580e7c9ed0752a68cd4aa42397e4e58a2a
### and stripped of server components, leaving just web.

### ansible playbooks & requirements for installing basic OMERO web


- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install OMERO.web server
    ansible-playbook playbook.yml
