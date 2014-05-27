# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :kisakone do |config|
    # Vagrant 1.5 box naming
    config.vm.box = "hashicorp/precise64"

    # expose port 80 so you can access kisakone with simple http://localhost
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :private_network, ip: "192.168.59.23"
    config.vm.synced_folder "../kisakone", "/kisakone", type: "nfs"
    config.vm.synced_folder ".", "/vagrant", type: "nfs"

    # install common basic tools
    config.vm.provision :shell, :path => "scripts/install-basics.sh"

    # by default, we use apache2 and mod_php as legacy option
    config.vm.provision :shell, :path => "scripts/install-apache.sh"

    # alternatively for way more performance but with no support to
    # mod_rewrite paths, this will install nginx+hhvm
    # uncomment this and comment out apache if you want it
    # config.vm.provision :shell, :path => "scripts/install-nginx-hhvm.sh"

    # install mysql as backend
    config.vm.provision :shell, :path => "scripts/install-mysql.sh"
    # install phpmyadmin for managing mysql
    config.vm.provision :shell, :path => "scripts/install-phpmyadmin.sh"

    # postfix is disabled in development as no email is supposed to be sent
    # uncomment on production install or when developing email features
    # config.vm.provision :shell, :path => "scripts/install-postfix.sh"

    # install nightwatch and selenium for running browser based ui tests
    config.vm.provision :shell, :path => "scripts/install-test-env.sh"

    # install default config and restore backup if present
    config.vm.provision :shell, :path => "scripts/configure.sh"
  end
end
