# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # use vmware fusion if you have it
  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "precise64_fusion"
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  end

  config.vm.define :kisakone do |config|
    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"
    config.vm.network :forwarded_port, guest: 80, host: 80
    config.vm.network :private_network, ip: "192.168.59.23"
    config.vm.synced_folder "../kisakone", "/kisakone", type: "nfs"
    config.vm.synced_folder ".", "/vagrant", type: "nfs"

    config.vm.provision :shell, :path => "scripts/install-apache.sh"
    # config.vm.provision :shell, :path => "scripts/install-postfix.sh"
    config.vm.provision :shell, :path => "scripts/install-phpmyadmin.sh"
    config.vm.provision :shell, :path => "scripts/install-test-env.sh"
  end
end
