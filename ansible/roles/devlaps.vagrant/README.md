Ansible Role: Vagrant
=========

This role installs vagrant and virtualbox on a linux server.

Currently supports both Red Hat and Debian based linux flavors.

Requirements
------------

None

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml).

   vbox_user: vagrant
   

Dependencies
------------

None

Example Playbook
----------------

Incorporate something ilke the fragment below:

    - hosts: all
      roles:
         - { role: devlaps.vagrant, vbox_user: "vagrant" }

License
-------

Apache Software License 2.0

Author Information
------------------

David Lapsley (devlaps@shipkode.com)

