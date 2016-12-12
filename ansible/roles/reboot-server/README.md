Reboot Server
=============

Reboot a server, optionally wait for it to return

If `reboot_server_timeout > 0` then wait for server to start.
This may fail if the server takes longer than `reboot_server_wait` seconds to shutdown all services, you can avoid this by increasing `reboot_server_wait`.
The post-reboot check requires direct access to the server from `localhost`.
If the server is behind a proxy you can run the check from a different host using `reboot_server_delegate`.


Role Variables
--------------

Optional variables:
- `reboot_server_always`: If `True` unconditionally reboot the server, otherwise only reboot if the kernel has changed, default `False`
- `reboot_server_delegate`: Run the reboot check from this node, default `localhost`.
- `reboot_server_shutdown_delay`: Wait for this time (seconds) before shutting down the server, default `5`
- `reboot_server_wait`: Wait for this time (seconds) before checking whether the server has restarted, default `30`
- `reboot_server_timeout`: Maximum time (seconds) to wait for a reboot, default `300`


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
