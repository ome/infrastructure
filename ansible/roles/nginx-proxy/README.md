Nginx Proxy
===========

Install Nginx for use as a front-end proxy.


Dependencies
------------

Requires the `nginx` role (automatically included).


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

If SSL is enabled you should install the certificates on the server and set the following two variables:

- `nginx_proxy_ssl_certificate`: Server path to SSL certificate
- `nginx_proxy_ssl_certificate_key`: Server path to SSL certificate key

Optionally this role can handle the certificate installation for you, if you specify the local source paths (default empty, you must handle the installation yourself):

- `nginx_proxy_ssl_certificate_source_path`: Local path to SSL certificate
- `nginx_proxy_ssl_certificate_key_source_path`: Local path to SSL certificate key

Backend servers:

- `nginx_proxy_backends`: List of dictionaries of backend servers with fields
  - `name`: A variable name for proxies using dynamic IP (ignored for static IPs)
  - `location`: The URL location
  - `server`: The backend server including scheme
  - `dynamic`: If `True` lookup IP on every request, default `False` (only lookup at startup).
  - `cache_validity`: The time that an object should be cached for, if omitted caching is disabled for this backend
  - `websockets`: If `True` enable proxying of websockets, default `False`

Redirection:

- `nginx_proxy_redirect_map`: List of dictionaries of URL redirects with fields:
  - `match`: The request uri to match (operators such as ~ are allowed, matching can include query arguments)
  - `dest`: The new uri
- `nginx_proxy_redirect_map_locations`: List of dictionaries of locations to be mapped using `nginx_proxy_redirect_map`
  - `location`: An nginx location to be mapped
  - `code`: Optional HTTP redirect status code, default `302` (use `301` for a permanent redirect)
- `nginx_proxy_direct_locations`: List of dictionaries of locations to be handled directly with the following fields. `location` is required, along with at least one of the other fields:
  - `location`: An nginx location to be mapped (required)
  - `redirect301`: The new uri to redirect to with code 301
  - `redirect302`: The new uri to redirect to with code 302
  - `index`: Nginx index locations
  - `root`: Root directory for requests
  - `alias`: Alias this directory to location
- `nginx_proxy_block_locations`: List of locations which should be blocked (404)

Use `nginx_proxy_direct_locations` with `redirect*` if you need to redirect based on Nginx `location` only, use `nginx_proxy_redirect_map` with `nginx_proxy_redirect_map_locations` if you also want to redirect based on query arguments.

Websockets:

- `nginx_proxy_websockets_enable`: This must be `True` if any proxies require proxying of websockets, default `False`
- `nginx_proxy_websockets_timeout`: The proxy read timeout for websocket connections

Caching:

- `nginx_proxy_cache_parent_path`: The parent directory for the nginx caches (optional)
- `nginx_proxy_caches`: List of dictionaries of cache specifications with fields:
  - `name`: Name of the cache
  - `keysize`: Amount of shared memory to use for storing cache keys
  - `inactive`: Time that items should be cached for
  - `match`: List of patterns to be stored in this cache, you probably want one item with the value `default` somewhere
- `nginx_proxy_cache_skip_uri`: List of URI patterns that shouldn't be cached (default: everything that doesn't match `nginx_proxy_cache_match_uri`)
- `nginx_proxy_cache_match_uri`: List of URI patterns that should be cached
- `nginx_proxy_cache_skip_arg`: List of query patterns that shouldn't be cached (default for this is always the result of `nginx_proxy_cache_*_url`)
- `nginx_proxy_cache_match_arg`: List of query patterns that should be cached (default for this is always the result of `nginx_proxy_cache_*_url`)

- `nginx_proxy_set_header_host`: Override the hostname seen by the backend proxy, default is to use the Nginx `$host` variable (recommended for most cases)
- `nginx_proxy_forward_scheme_header`: A header to be set containing the scheme (e.g. `http`, `https`) that will be passed to the backend
- `nginx_proxy_debug_cache_headers`: If `True` add extra headers for debugging (not for production), default `False`
- `nginx_proxy_cache_ignore_headers`: Headers to be ignored, e.g. `'"Set-Cookie" "Vary" "Expires"'`
- `nginx_proxy_cache_hide_headers`: Headers to be hidden from clients in cached responses, must be a list e.g. `[Set-Cookie]`
- `nginx_proxy_cache_key`: Override the default Nginx cache key, for example `"$host$request_uri"` to ignore session cookies
- `nginx_proxy_cache_use_stale`: Situations in which stale cache results should be returned, see `defaults/main.yml` for default
- `nginx_proxy_cache_lock_time`: Prevent multiple backend requests to the same object (subsequent requests will wait for the first to either return or time-out), default 1 minute
- `nginx_proxy_cachebuster_port`: An alternative port which can be used to force a cache refresh, disabled by default. You should ensure this is firewalled. If SELinux is enabled and the port is not one that nginx can bind by default (typically 80, 81, 443, 488, 8008, 8009, 8443, 9000 are allowed by default) you must update your policy yourself.

Warning: `max_size` is not set on any disk caches, so you should put `nginx_proxy_cache_parent_path` on a separate partition.


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

Advanced configuration: force https, enable caching using an example predefined configuration (see `vars/example-omero.yml`), use HSTS, enable HTTP2

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
      vars_files:
      - roles/nginx-proxy/vars/example-omero.yml


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
