Local Accounts
==============

Create or remove local user accounts.


Role Variables
--------------

- `local_accounts_create`: A list of dictionaries containing information on the user to be created (default: empty).
  Each item may contain the following fields:
  - `user`: username (required)
  - `uid`: user-ID (required)
  - `groups`: optional list of groups to be appended to the user's default groups
  - `password`: optional password hash, only set if the user is created in this invocation
  - `sshpubkey`: optional SSH public key, will be appended to any existing keys if not already present
  - `require_first_password`: optional, if `True` attempt to force a newly created user to change their password on first login, default `False`.

For example, if you set `sshpubkey`, omit `password` and set `require_first_password: True` the user should be able to log in over SSH using their key, and should be prompted to set a password immediately.
However, failing to set a password will also allow any existing user to `su` to the new users without a password.

- `local_accounts_delete`: List of usernames to be deleted (default: empty). Home directories will not be removed.


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: local-accounts
        local_accounts_create:
        - user: test1
          uid: 1001
        - user: test2
          uid: 1002
          groups: wheel
          sshpubkey: "ssh-rsa XXXXX"
        local_accounts_delete:
        - user3
        - user4

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
