# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :kisakone do |config|
    # Vagrant 1.5 box naming
    config.vm.box = "hashicorp/precise64"

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
