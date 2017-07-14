### ansible playbook & requirements for www server

- after installing ansible and ansible-galaxy,
    ansible-galaxy install -r requirements.yml -p roles

- install and configure server
    ansible-playbook www.yml
