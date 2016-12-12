#!/usr/bin/ruby
#
# gen_vmInventory.rb - A ruby script to generate vmInventory.xml for VMware Workstation Pro
#
# usage:
#   $ sudo systemctl stop vmware-workstation-server.service
#   $ ./gen_vmInventory.rb /var/lib/vmware/Shared\\ VMs/ > ~/vmInventory.xml
#   $ sudo cp ~/vmInventory.xml /etc/vmware/hostd/
#   $ sudo systemctl start vmware-workstation-server.service
#
# github:
#   "https://github.com/yoggy/gen_vmInventory
# 
# license:
#     Copyright (c) 2016 yoggy <yoggy0@gmail.com>
#     Released under the MIT license
#     http://opensource.org/licenses/mit-license.php;
#
require 'rexml/document'

def usage
  puts "usage : #{$0} vmware_shared_vms_diretory"
  puts ""
  puts "  example:"
  puts "    $ ./gen_vmInventory.rb /var/lib/vmware/Shared\\ VMs/"
  puts ""
  exit 0
end

usage if ARGV.size == 0

vmware_shared_vms_diretory = ARGV[0]

unless File.exist?(vmware_shared_vms_diretory)
  $stderr.puts "directory not found... vmware_shared_vms_diretory=" + vmware_shared_vms_diretory
  exit 1
end

if File::ftype(vmware_shared_vms_diretory) != "directory"
  $stderr.puts "ARGS[0] is not directory name...=vmware_shared_vms_diretory" + vmware_shared_vms_diretory
  exit 1
end

if vmware_shared_vms_diretory[-1] != '/'
  vmware_shared_vms_diretory += '/'
end

#
doc = REXML::Document.new
root = doc.add_element 'ConfigRoot'

vmxs = Dir.glob(vmware_shared_vms_diretory + "**/*.vmx")
vmxs.sort!

vmxs.each_with_index do |d, idx|
  e = REXML::Element.new('ConfigEntry')
  e.add_attribute('id', sprintf("%04d", idx))
  e.add_element('objID').text=sprintf("%d", idx+1)
  e.add_element('vmxCfgPath').text=d
  root.add_element(e)
end

formatter = REXML::Formatters::Pretty.new()
formatter.width = 10240
formatter.compact = true
formatter.write(doc, $stdout)
puts
