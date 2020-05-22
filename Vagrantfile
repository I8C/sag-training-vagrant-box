# -*- mode: ruby -*-
# vi: set ft=ruby :

# Add required plugins to the required_plugins array of strings variable below:
# 1) vagrant-vbguest
# This plugin will automatically update the VirtualBox Guest Additions
# to the version that matches your VirtualBox version.
#
# 2) vagrant-reload
# Automatically reload the box using the vagrant-reload plugin
# to enable automatic syncing of /vagrant folder and other stuff after provisioning.
#
required_plugins = %w( vagrant-vbguest vagrant-reload )
restart_manually = false

required_plugins.each do |plugin|
  if not Vagrant.has_plugin?(plugin)
    system "vagrant plugin install #{plugin}"
    restart_manually = true
  end
end

if restart_manually
  puts "Execute the vagrant utility again now that required plugins have been installed"
  exit
end

Vagrant.configure("2") do |config|

  config.vm.box = "gusztavvargadr/sql-server"
  config.vm.box_version = "2019.0.2003"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "8192"
    vb.cpus = "4"
    vb.name = "webMethods10.5-1.0.0.box"
    # Enable copy paste from/to host/guest
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    # Increase video RAM to be able to resize on large screen
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  config.vm.provision "setup", privileged: true, type: "shell", path: "setup.ps1"

  # Reload to apply changing the hostname
  config.vm.provision :reload

  config.vm.provision "postsetup", privileged: true, type: "shell", path: "postsetup.ps1"


end
