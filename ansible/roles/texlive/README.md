texlive
===========

Install the current version of TeX Live.

Starting point taken from https://github.com/shirou/menes/tree/master/ansible/roles/texlive, author https://github.com/shirou. Modified to allow the defaults/main.yml role variables to overwrite the values in the install-tl.profile file, which would have had to have been modified manually. 

Role Variables
--------------

Defaults: `defaults/main.yml` 

contains the installation folder variables which are writeen to install-tl.profile. 


- `texlive_dest`: Top level install-to folder, Default of /opt/texlive
- `texlive_version`: "Version" part of install-to folder. Default of `2015`.

- `TEXDIR`: specifies where to install texlive. Default of `/opt/texlive/2015`, constructed from  "{{ texlive_dest }}/{{ texlive_version }}".
- `TEXMFLOCAL`: constructed from  "{{ texlive_dest }}/texmf-local".
- `TEXMFSYSCONFIG`: constructed from  "{{ TEXDIR }}/texmf-config".
- `TEXMFSYSVAR`: constructed from  "{{ TEXDIR }}/texmf-var".
- `TEXMFVAR`: constructed from  "~/.texlive{{ texlive_version }}/texmf-var".


Dependencies
------------

None.


Author Information
------------------

Partially https://github.com/shirou.

ome-devel@lists.openmicroscopy.org.uk
