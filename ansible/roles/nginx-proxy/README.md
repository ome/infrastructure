Nginx Proxy
===========

Install Nginx for use as a front-end proxy.

Role Variables
--------------

Defaults: `defaults/main.yml`

- `nginx_proxy_worker_processes`: Number of worker processes, default 1
- `nginx_proxy_ssl`: If `True` enable SSL, default `False`
- `nginx_proxy_http2`: If `True` enable HTTP2, ignored if `nginx_proxy_ssl: False`, default `False`
- `nginx_proxy_force_ssl`: If True permanently redirect all `http` requests to `https` (efault `False`


If SSL is enabled you should install the certificates on the server (not handled by this role) and set the following two variables:

- `nginx_proxy_ssl_certificate`: Server path to SSL certificate
- `nginx_proxy_ssl_certificate_key`: Server path to SSL certificate key

Optional variables:

- `nginx_proxy_buffers`: Number and size of proxy buffers (optional)
- `nginx_dynamic_proxy_resolvers`: If the proxied servers are referred to by hostname instead of IP addresses you must provide at least one DNS server
- `nginx_proxy_hsts_age`: The max-age in seconds for a HSTS (HTTP Strict Transport Security) header, default is to omit this header

Backend servers:

- `nginx_proxy_backends`: List of dictionaries of backend servers with fields
  - `name`: A variable name for proxies using dynamic IP (ignored for static IPs)
  - `location`: The URL location
  - `server`: The backend server including scheme
  - `dynamic`: If `True` lookup IP on every request, default `False` (only lookup at startup).


Example Playbooks
-----------------

Proxy:
- http://localhost/ to http://a.internal/ statically, make a single DNS request for `a.internal` at the start
- http://localhost/b to http://b.internal/subdir dynamically, making a DNS request for `b.internal` on every request

    - hosts: localhost
      roles:
      - role: nginx_proxy
        nginx_proxy_backends:
        - location: /
          server: http://a.internal
        - name: testb
          location: /b
          server: http://b.internal/subdir
          dynamic: True


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
