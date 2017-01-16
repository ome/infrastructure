# https://gist.github.com/jjshoe/ace3070906e5bc5cc432
# https://github.com/ansible/ansible/pull/14742
# https://github.com/ansible/ansible/issues/14693

# Make coding more python3-ish

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import os
import time
import sys

from ansible.plugins.callback import CallbackBase


class CallbackModule(CallbackBase):
    """
    This callback module exits with non-zero if no hosts match
    """
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = 'aggregate'
    CALLBACK_NAME = 'no_hosts_match_exit_non_zero'
    CALLBACK_NEEDS_WHITELIST = False

    def __init__(self):
        super(CallbackModule, self).__init__()

    def playbook_on_stats(self, stats):
        found_stats = False

        for key in ['ok', 'failures', 'dark', 'changed', 'skipped']:
            if len(getattr(stats, key)) > 0:
                found_stats = True
                break

        if found_stats == False:
            print('ERROR: No hosts matched')
            sys.exit(10)
