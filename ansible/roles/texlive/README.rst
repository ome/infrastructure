texlive
===========

An ansible role to install texlive

Starting point taken from https://github.com/shirou/menes/tree/master/ansible/roles/texlive, author https://github.com/shirou. Modified to allow the defaults/main.yml role variables to overwrite the values in the install-tl.profile file, which would have had to have been modified manually. 

Role Variables
--------------

`defaults/main.yml` contains the installation folder variables which are writeen to install-tl.profile. 

- `TEXDIR` specifies where to install texlive. Default of `/opt/texlive/2015`, constructed from `texlive_dest` and `texlive_version`.


