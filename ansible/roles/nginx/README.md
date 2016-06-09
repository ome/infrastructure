Nginx
=====

Install upstream Nginx.

TODO: Add configuration options.


Role Variables
--------------

- `nginx_keep_default_configs`: If `True` keep the default site configuration files in `nginx/conf.d`, default `False` (disable them)

Log rotation:

- `nginx_logrotate_interval`: Rotate log files at this interval, default `daily`
- `nginx_logrotate_backlog_size`: Number of backlog files to keep, default `366`


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
