### Taken from manics/ansible-public-omero-example.git
### at bc730e580e7c9ed0752a68cd4aa42397e4e58a2a
### and stripped of server components, leaving just server.

### ansible playbooks & requirements for installing basic OMERO server.


- playbooks set up to run from localhost rather than remotely

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install OMERO server
    ansible-playbook playbook.yml
