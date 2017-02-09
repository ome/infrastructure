# Contributing

General guidelines for contributing to the Ansible-based
infrastructure used by OME.

* Roles
  - SemVer is used for developing roles.
  - Production roles should be distributed via Galaxy.
  - Prefix variables should be prefixed with role names.
  - Molecule should be used for testing complex roles.

* Playbooks
  - Prefer the long-format
