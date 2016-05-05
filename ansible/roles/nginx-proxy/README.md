Nginx Proxy
===========

Install Nginx for use as a front-end proxy.

Role Variables
--------------

Defaults: `defaults/main.yml`

- `nginx_proxy_worker_processes`: Number of worker processes, default 1
- `nginx_proxy_buffers`: Number and size of proxy buffers (optional)
- `nginx_dynamic_proxy_resolvers`: If the proxied servers are referred to by hostname instead of IP addresses you must provide at least one DNS server

SSL variables:

- `nginx_proxy_ssl`: If `True` enable SSL, default `False`
- `nginx_proxy_hsts_age`: The max-age in seconds for a HSTS (HTTP Strict Transport Security) header, default is to omit this header
- `nginx_proxy_http2`: If `True` enable HTTP2, default `False`
- `nginx_proxy_force_ssl`: If `True` permanently redirect all `http` requests to `https`, default `False`

If SSL is enabled you should install the certificates on the server (not handled by this role) and set the following two variables:

- `nginx_proxy_ssl_certificate`: Server path to SSL certificate
- `nginx_proxy_ssl_certificate_key`: Server path to SSL certificate key

Backend servers:

- `nginx_proxy_backends`: List of dictionaries of backend servers with fields
  - `name`: A variable name for proxies using dynamic IP (ignored for static IPs)
  - `location`: The URL location
  - `server`: The backend server including scheme
  - `dynamic`: If `True` lookup IP on every request, default `False` (only lookup at startup).
  - `cache_validity`: The time that an object should be cached for, if omitted caching is disabled for this backend

Caching:

- `nginx_proxy_cache_parent_path`: The parent directory for the nginx caches (optional)
- `nginx_proxy_caches`: List of dictionaries of cache specifications with fields:
  - `name`: Name of the cache
  - `keysize`: Amount of shared memory to use for storing cache keys
  - `inactive`: Time that items should be cached for
  - `match`: Patterns to be stored in this cache, you probably want one item with the value `default`
- `nginx_proxy_cache_skip`: Don't cache these patterns (default: everything that doesn't match `nginx_proxy_cache_match`)
- `nginx_proxy_cache_match`: Cache these patterns

- `nginx_proxy_debug_cache_headers`: If `True` add extra headers for debugging (not for production), default `False`
- `nginx_proxy_ignore_headers`: Headers to be ignored, e.g. `'"Set-Cookie" "Vary" "Expires"'`
- `nginx_proxy_cache_use_stale`: Situations in which stale cache results should be returned, see `defaults/main.yml` for default


nginx_proxy_debug_cache_headers: False


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

Advanced configuration: force https, enable caching, use HSTS, enable HTTP2

    - hosts: localhost
      roles:
      - role: nginx_proxy
        nginx_proxy_backends:
        - location: /
          server: http://a.internal
          cache_validity: 1h
        nginx_proxy_worker_processes: 4
        nginx_proxy_ssl: True
        nginx_proxy_ssl_certificate: /etc/nginx/ssl/website.crt
        nginx_proxy_ssl_certificate_key: /etc/nginx/ssl/website.key
        nginx_proxy_http2: True
        nginx_proxy_force_ssl: True
        nginx_proxy_hsts_age: 31536000
        # Example predefined cache configurations are in defaults/main.yml:
        nginx_proxy_cache_match: "{{ nginx_proxy_cache_match_omero }}"
        nginx_proxy_caches: "{{ nginx_proxy_caches_omero }}"


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
