Nginx SSL Self-Signed
=====================

Generate self-signed SSL certificates for Nginx, for internal testing.

Role Variables
--------------

Defaults: `defaults/main.yml`

Optional variables:

- `nginx_ssl_certificate_subject`: Certificate subject
- `nginx_ssl_certificate_days`: Certificate validity, default 365 days
- `nginx_ssl_certificate`: Server path to SSL certificate
- `nginx_ssl_certificate_key`: Server path to SSL certificate key

Note this role does not configure Nginx for SSL, nor does it restart Nginx.
This should be handled elsewhere.
System variables:

- `runningindocker`: systemd doesn't currently work inside Docker without some fiddling. Set this variable to `True` to start nginx directly, default `False`.

Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
