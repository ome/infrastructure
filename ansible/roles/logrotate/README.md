Logrotate
=========

Customise log-rotation.


Role Variables
--------------

All variables are optional, see `defaults/main.yml`:
- `logrotate_interval`: Rotate logs at this interval (default `weekly`)
- `logrotate_backlog_size`: Number of historic log files to keep (default `12`)
- `logrotate_compress`: If True compress historic log files (default `True`)


Example Playbook
----------------

    - hosts: localhost
      roles:
      - role: logrotate
        logrotate_backlog_size: 52


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
