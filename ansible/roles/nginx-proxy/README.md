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

- `nginx_proxy_buffers`: Number and size of proxy buffers (optional)
- `nginx_dynamic_proxy_resolvers`: If the proxied servers are referred to by hostname instead of IP addresses you must provide at least one DNS server

Backend servers:

- `nginx_dynamic_proxies`: List of dictionaries of backend servers (hosts/IPs will be dynamically resolved on every request)
- `nginx_static_proxies`: List of dictionaries of backend servers (hosts/IPs will be resolved once)


Example Playbooks
-----------------

Proxy:
- http://localhost/ to http://a.internal/
- http://localhost/b to http://b.internal/subdir

Dynamically, making a DNS request for `a.internal` on every request

    - hosts: localhost
      roles:
      - role: nginx_proxy
        nginx_dynamic_proxies:
        - name: testa
          location: /
          server: a.internal
        - name: testb
          location: /b
          server: b.internal/subdir

Statically, make a single DNS request for `a.internal` at the start

    - hosts: localhost
      roles:
      - role: nginx_proxy
        nginx_static_proxies:
        - location: /
          server: a.internal
        - location: /b
          server: b.internal/subdir


Note internal communication with backend servers is currently done over plain `http`, however `https` should work for front-end connections.


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
