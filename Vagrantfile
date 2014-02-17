# Example 1
#
# Single box with default options.
#
Vagrant::Config.run do |config|
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.vm.provision :shell, :path => "provision.sh", :privileged => false
end
