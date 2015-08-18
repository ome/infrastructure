#! /usr/bin/env python
# Check GitHub organization

import sys
from scc.git import get_github, get_token


def check_members(org):
    """Return the list of all members and check visibility"""

    # Return list of public and all members
    public_members = list(org.get_public_members())
    members = list(org.get_members())

    # Compute the diff between all members and public members
    l1 = [x.login for x in members]
    l2 = [x.login for x in public_members]
    diff = set(l1) - set(l2)
    if diff:
        print 'Private members: %s' % ", ".join(diff)

    return members


def main(args):
    if len(args) is not 2:
        raise Exception('Arguments: ORGANIZATION')

    gh = get_github(get_token())
    org = gh.get_organization(args[1])

    members = check_members(org)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
