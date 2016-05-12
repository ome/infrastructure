#!/usr/bin/env python

from os.path import dirname, join
from subprocess import call
import sys

sys.exit(call([
    join(dirname(__file__), 'openstack.py'), '--private'] + sys.argv[1:]))
