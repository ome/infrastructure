# Infrastructure and Ansible

This repository stores all non-private information required for setting up production servers with Ansible in the Open Microscopy environment.
This includes productions services, and continuous infrastructure/deployment servers, but does not include short-term test servers or infrastructure which does not need to be maintained long term.

Since it is a relatively new initiative and is still under heavy development it may be necessary to make breaking changes.

Wherever possible configuration data is included in this public repository, but inevitably some private configuration data (host and group variables) are not included.
In many cases it is possible to run a role using the default role arguments, the main exceptions being roles related to hardware configuration, or which interact with external services.


## Overview

At present there are effectively two groups of hosts and playbooks, `idr-*` and `ci-*`.
Both share the same set of roles.
The inventory files, and group and host specific configuration files, are currently held in a private repository.

`group_vars` contains variables which are common to most hosts in that group.
In general most configuration that differs from the role defaults should be done here.

`host_vars` contains host specific configuration e.g. network configuration, or overrides/additions to variables specified in `group_vars`

There are several playbooks, each corresponding to a host group.
Since host-groups correspond to servers with a similar purpose this provides an easy way to manage groups of services (note that a server can be in multiple groups).
In addition there are high-level playbooks that include the individual group playbooks, to allow the entire infrastructure to be managed as a whole.

For examples of running playbooks from this repository see [example_workflows.md].
