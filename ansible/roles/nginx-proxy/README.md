Nginx Proxy
===========

Install Nginx for use as a front-end proxy.

Role Variables
--------------

Defaults: `defaults/main.yml`

- `nginx_proxy_worker_processes`: Number of worker processes, default 1
- `nginx_proxy_ssl`: If `True` enable SSL, default `False`

If SSL is enabled you should install the certificates on the server (not handled by this role) and set the following two variables:

- `nginx_proxy_ssl_certificate`: Server path to SSL certificate
- `nginx_proxy_ssl_certificate_key`: Server path to SSL certificate key

Optional variables:

- `nginx_dynamic_proxy_resolvers`: If the proxied servers are referred to by hostname instead of IP addresses you must provide at least one DNS server
- `nginx_dynamic_proxy_buffers`: Number and size of proxy buffers (optional)

Backend servers:

- `nginx_dynamic_proxies`: List of dictionaries of backend servers

For example:

    nginx_dynamic_proxies:
    - name: testa
      location: /
      server: a.internal
    - name: testb
      location: /b
      server: b.internal/subdir

will configure this server to proxy:
- http://this.server/ to http://a.internal/
- http://this.server/b to http://b.internal/subdir

Note internal communication with backend servers is currently done over plain `http`, however `https` should work for front-end connections.

System variables:

- `runningindocker`: systemd doesn't currently work inside Docker without some fiddling. Set this variable to `True` to start nginx directly, default `False`.

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
