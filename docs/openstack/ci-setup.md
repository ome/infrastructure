# CI OpenStack machine setup

This is split into three parts:

- Creating an OpenStack instance
- Setting up the instance to be managed with ansible
- Setting up the CI configuration

## Creating an instance

Firstly, add the machine configuration to management_tools.

- Add a host inventory file to `ansible/inventory/host_vars/<name>`.
  This must contain appropriate `openstack_machine` and
  `openstack_volumes` sections.  See other hosts for examples.

- Add the machine name to the appropriate groups in
  `ansible/inventory/ci-openstack-hosts`.  Make sure to include it in
  the appropriate platform and deployment groups, and in each CI role
  group this instance should provide.

Run the following:

```
ansible-playbook -e "ci_host=<host>" -i <management_tools>/ansible/inventory/ci-openstack-hosts <infrastructure>/ansible/os-ci-create-machine.yml --vault-password-file=<vault>
```

Substitute all names marked with `<name>` for the appropriate names
and paths.

When complete, you will see this instance created using either the
OpenStack Horizon interface or the command-line.  You should be able
to SSH into it with the shared "ci" key.  You'll need this key for the
next step.  For Windows platforms, a password was generated which
you'll need to use instead; see the [Windows image](windows-image.md)
page for more details.

## Ansible setup

This part installs the necessary packages (such as Python) for running
Ansible, and also creates a common user (`ci-admin`) for
administration using `authorized_keys` specified in management_tools
(`ansible/inventory/group_vars/ci-openstack/vars`).  After this step,
the system can be administered with ansible using the `ci-admin`
account and your own SSH credentials.

```
# SSH in manually to add the host to your known_hosts
ssh <user>@<host>

ansible-playbook -l <host> -e "ansible_user=<user>" -u <user> -i <management_tools>/ansible/inventory/ci-openstack-hosts <infrastructure>/ansible/ci-initial-setup.yml --vault-password-file=<vault>
```

As before, substitute all names marked with `<name>` for the
appropriate names and paths.  `<user>` is specific to the image.  It's
something like `centos`, `freebsd`, `ubuntu`, `Admin` or similar.

Once this completes, the node is ready to be configured for its
purpose.  You shouldn't need to run the initial setup playbook again
(but you can if you need to).

## CI setup

Run:

```
ansible-playbook -l <host|group> -i <management_tools>/ansible/inventory/ci-openstack-hosts <infrastructure>/ansible/ci-setup.yml --vault-password-file=<vault>
```

Once this step completes, the node is ready to be added to jenkins.
This step may be rerun as needed, and run on groups of CI nodes.
