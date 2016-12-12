gen_vmInventory.rb
====
A ruby script to generate vmInventory.xml for VMware Workstation Pro.

Usage
----

    $ sudo systemctl stop vmware-workstation-server.service
    $ ./gen_vmInventory.rb /var/lib/vmware/Shared\ VMs/ > ~/vmInventory.xml
    $ sudo cp ~/vmInventory.xml /etc/vmware/hostd/
    $ sudo systemctl start vmware-workstation-server.service

github
----
  - https://github.com/yoggy/gen_vmInventory

Copyright and license
----

Copyright (c) 2016 yoggy

Released under the [MIT license](LICENSE.txt)
