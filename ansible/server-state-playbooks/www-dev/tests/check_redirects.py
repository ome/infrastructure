# Test redirects
#
# Test the default host:
#   pytest check_redirects.py
#
# Test a different host:
#   HOST=http://www-dev.openmicroscopy.org pytest check_redirects.py

import os
import pytest
import requests


HOST = os.getenv('HOST', 'https://infra-testpr.openmicroscopy.org')


# Based on
# https://github.com/sbesson/infrastructure/blob/3fd40a3ad61a0f496b4815e4abbeadca798ce210/ansible/server-state-playbooks/www-dev/www-dev.yml#L172
@pytest.mark.parametrize('uri,expect', [
    ('/site', '/'),
    ('/site/about/licensing-attribution', '/licensing'),
    ('/site/about/ome-contributors', '/contributors'),
    ('/site/about/partners', '/commercial-partners'),
    ('/site/about/development-teams', '/teams'),

    ('/site/community', '/support'),
    ('/site/community/mailing-lists', '/support'),
    ('/site/community/jobs', '/careers'),

    ('/site/support', '/docs'),
    ('/site/news', '/announcements'),
])
@pytest.mark.parametrize('suffix', ['', '/'])
def test_redirect_with_slash(uri, expect, suffix):
    r = requests.head('%s%s%s' % (HOST, uri, suffix))
    assert r.is_redirect
    assert r.headers['Location'] == '%s%s' % (HOST, expect)


def test_404():
    uri = '/non-existent/path'
    r = requests.head('%s%s' % (HOST, uri))
    assert r.status_code == 404
