# -*- mode: ruby -*-
# vi: set ft=ruby :
# Author: Tuomo Tanskanen <tuomo@tanskanen.org>

Vagrant.configure("2") do |config|

  config.vm.define :kisakone do |config|
    # Virtualbox box
    config.vm.provider "virtualbox" do |v, override|
      override.vm.box = "hashicorp/precise64"
      # config.vm.network :private_network, ip: "192.168.59.24"
      # config.vm.synced_folder "../kisakone", "/kisakone", type: "nfs"
      # config.vm.synced_folder ".", "/vagrant", type: "nfs"
    end

    # LXC
    config.vm.provider "lxc" do |v, override|
      override.vm.box = "fgrehm/precise64-lxc"
    end

    # expose port 80 so you can access kisakone with simple http://localhost
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.synced_folder "../kisakone", "/kisakone"

    # install common basic tools
    config.vm.provision :shell, :path => "scripts/install-basics.sh"

    # install mysql as backend
    config.vm.provision :shell, :path => "scripts/install-mysql.sh"

    # by default, we use apache2 and mod_php as legacy option
    config.vm.provision :shell, :path => "scripts/install-apache.sh"

    # uncomment this and comment out apache if you want it
    # config.vm.provision :shell, :path => "scripts/install-nginx-hhvm.sh"

    # postfix is disabled in development as no email is supposed to be sent
    # uncomment on production install or when developing email features
    # config.vm.provision :shell, :path => "scripts/install-postfix.sh"

    # install unittest framework
    config.vm.provision :shell, :path => "scripts/install-phpunit.sh"

    # install nightwatch and selenium for running browser based ui tests
    config.vm.provision :shell, :path => "scripts/install-nodejs.sh"
    config.vm.provision :shell, :path => "scripts/install-test-env.sh"

    # install default config and restore backup if present
    config.vm.provision :shell, :path => "scripts/configure.sh"
  end
end
