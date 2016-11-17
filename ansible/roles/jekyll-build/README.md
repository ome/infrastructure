Jekyll site
===========

Install Jekyll and setup a site.


Dependencies
------------

This role requires `git` and therefore includes `versioncontrol-utils` as a dependency.


Role Variables
--------------

Required variables:
- `jekyll_build_git_repo`: URL to a git repository containing the site

Recommended variables:
- `jekyll_build_name`: The name of the site
- `jekyll_build_sourcedir`: Clone the git repository into this directory

Optional variables:
- `jekyll_build_root`: The destination directory for the Jekyll output
- `jekyll_build_owner`, `jekyll_build_group`: The system owner and group of `jekyll_build_sourcedir` and `jekyll_build_root`, default `root:root`
- `jekyll_build_git_branch`: Git branch
- `jekyll_build_force_git`: Remove modified files in the git repository, default `False`
- `jekyll_build_force_rebuild`: Force a rebuild even if the git checkout is unchanged, default `False`
- `jekyll_build_baseurl`: Prefix for the Jekyll site


Author Information
------------------

ome-devel@lists.openmicroscopy.org.uk
