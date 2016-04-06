Sudoers
=======

Configure sudoers.

TODO: Expand this role


Role Variables
--------------

- `sudoers_individual_commands`: List of dictionaries with keys: `[{user: username, become: becomeuser, command: "/usr/bin/command args" }]`


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: sudoers
        sudoers_individual_commands:
        - user: user1
          become: root
          command: /usr/bin/mount *
        - user: user2
          become: root
          command: /usr/bin/less /var/log/*


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
