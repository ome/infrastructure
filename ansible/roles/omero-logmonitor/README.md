OMERO LogMonitor
================

Install OmeroFenton for error notifications in Jabber


Requirements
------------

The user account that the bot is run as (default `omero`) must already exist, it will not be created automatically in case the account requires special configuration.
The default configuration assumes OMERO.server has been installed into its default location using the `omero-server` role.


Role Variables
--------------

Required variables:

- `omero_logmonitor_jabber_user`: Jabber account id
- `omero_logmonitor_jabber_password`: Jabber account password
- `omero_logmonitor_jabber_room`: Multi-user chatroom to send notifications to

Recommended variables:

- `omero_logmonitor_jabber_nick`: Jabber nickname
- `omero_logmonitor_server_name`: String used to identify alerts from this server

Optional variables:

- `omero_logmonitor_jabber_server`: The jabber server if it doesn't match the Jabber account id (e.g. Google Talk)
- `omero_logmonitor_email_oom`: Whether to enable email notifications of out-of-memory errors, if `True` the `omero_logmonitor_email_*` properties must be defined, default `False`.
- `omero_logmonitor_email_smtp`: SMTP server
- `omero_logmonitor_email_from`: From address for email alerts
- `omero_logmonitor_email_to`: To address for email alerts@example.org
- `omero_logmonitor_logs_dir`: Base directory of the OMERO.server logs
- `omero_logmonitor_logfiles`: Dictionaries of log file monitoring parameters

See `defaults/main.yml` for the full list of optional variables.
This is particular important if you are using a modified OMERO configuration with log files in a different location, or with non-standard logfiles.


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: localhost
      roles:
      - role: omero-logmonitor
        omero_logmonitor_jabber_user: omero-logmonitor@jabber.example.org
        omero_logmonitor_jabber_password: secret-password
        omero_logmonitor_jabber_room: alerts
        omero_logmonitor_jabber_nick omero-logmonitor
        omero_logmonitor_server_name: omero test instance
        # Include the follow variables to setup email OOM alerts
        omero_logmonitor_email_oom: True
        omero_logmonitor_email_smtp: smtp.example.org
        omero_logmonitor_email_from: omero-logmonitor@example.org
        omero_logmonitor_email_to: sysadmin-alerts@example.org


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
