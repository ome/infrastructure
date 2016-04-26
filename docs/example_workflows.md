# Example Ansible Workflows


## Variables used in the examples

- `GROUP`: A group-name
- `HOST`: The hostname of the host to be modified
- `INVENTORY`: The Ansible inventory (hosts) file


## Optional flags

- `-v`: Increase verbosity of Ansible messages, can by repeated
- `--ask-become-pass`: If a `sudo` password is required add this flag
- `-l HOST-OR-GROUP`: When running playbooks that apply to multiple groups or hosts this flag can be used to manage a subset of those hosts. Use `--list-hosts` to list the matching hosts.


## Provisioning a new system

1. Add one or more entries for `HOST` to `INVENTORY`. Most groups in `INVENTORY` should match a playbook. A host can be in multiple groups, and should be in at least one top-level group (e.g. `idr`). These top-level group are useful for managing generic playbooks such as the initial basic setup, or upgrades.
2. If necessary create a host-specific variables file `host_vars/HOST`. Use this if for instance you are configuring the hosts's network with Ansible.
3. If the host has a temporary IP address include this in the inventory, e.g. `HOST ansible_host=192.168.0.1`. You can also include other connection parameters if needed.
4. Run: `ansible-playbook -i INVENTORY idr-initial.yml -l HOST`
5. Reboot the system to ensure any updates are active. This is particularly important if external kernel modules are required, or if the network configuration has changed.
6. If necessary remove any temporary parameters added in Step 3.
7. Run any other playbooks individually, e.g.: `ansible-playbook -i INVENTORY idr-docker-localstorage.yml -l HOST`
8. Alternatively if you are sure that a reboot is not necessary before installing other packages you can do steps 4-7 in one go by running the parent playbook which should automatically calls other playbooks: `ansible-playbook -i INVENTORY idr-provision.yml -l HOST`
9. Ansible should be idempotent. If any errors occur which you suspect may be transient just rerun Ansible.
   - The main exception to this is if a handler, or some other task that depends on a previous task having changed things, fails. If you rerun Ansible the handler may not be retried since the task which triggered it may not be rerun, in which case you may need to manually run the handler command.


## Adding an existing system to a group

1. Add `HOST` to another `GROUP` in `INVENTORY`.
2. Check the corresponding group variables `group_vars/GROUP`. If necessary set any host-specific variables in `host_vars/HOST`.
3. Run the corresponding playbook: `ansible-playbook -i INVENTORY GROUP.yml -l HOST`


## Upgrading packages

1. Ensure you are aware of the implications of upgrading packages. For instance, a kernel update may required custom kernel modules to be recompiled, which may required modifying and running other playbooks.
2. Most playbooks should be idempotent, for instance they should use `state: present` instead of `latest` when packages are installed. To upgrade a system run one of the upgrade playbooks, for example: `ansible-playbook -i INVENTORY all-upgrade.yml -l HOST`
3. If necessary make any changes to variables and run any playbooks identified in Step 1.


## Checking the state of one or more systems

1. Run Ansible in check mode with a single playbook to see whether it would make any changes (but note some modules have bugs where they will report a change even if none would've been made, so you will have to use your judgement): `ansible-playbook -i INVENTORY GROUP.yml -C`
2. Alternatively you can use one of the parent playbooks if you also want to check everything, including whether any upgrades are available: `ansible-playbook -i INVENTORY idr-provision.yml -C`


## TODO: Complicated playbooks

Anything related to GPFS
