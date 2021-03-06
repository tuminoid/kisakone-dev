# -*- mode: ruby -*-
# vi: set ft=ruby :
# Copyright (c) 2013-2016 Tuomo Tanskanen <tuomo@tanskanen.org>

# You can configure this installer by exporting environment variables:
# KISAKONE_NGINX   = install nginx+hhvm instead of apache+mod_php
# KISAKONE_TESTS   = install test frameworks
# KISAKONE_POSTFIX = install postfix

Vagrant.configure("2") do |config|

    config.vm.define :kisakone do |config|
        # Virtualbox box
        config.vm.provider "virtualbox" do |v, override|
            override.vm.box = "ubuntu/trusty64"
            v.memory = 2048
        end

        # LXC
        config.vm.provider "lxc" do |v, override|
            override.vm.box = "fgrehm/trusty64-lxc"
        end

        # vmware
        config.vm.provider "vmware_fusion" do |v, override|
            override.vm.box = "puphpet/ubuntu1404-x64"
            v.vmx["memsize"] = "2048"
        end

        # parallels
        config.vm.provider "parallels" do |v, override|
            override.vm.box = "parallels/ubuntu-14.04"
            v.memory = 2048
        end

        # for vagrant-cachier
        if Vagrant.has_plugin?("vagrant-cachier")
            config.cache.scope = :machine
            config.cache.synced_folder_opts = { }
            config.cache.enable :generic, { :cache_dir => "/var/cache/generic" }
        end

        # expose port 80 so you can access kisakone with simple http://localhost
        config.vm.network :forwarded_port, guest: 8080, host: 8080
        config.vm.network :forwarded_port, guest: 3306, host: 3306
        config.vm.synced_folder "../kisakone", "/kisakone"
        if File.directory?("../pdga-integration")
            config.vm.synced_folder "../pdga-integration", "/kisakone/pdga"
        end
        if File.directory?("../kisakone-live")
            config.vm.network "public_network"
            config.vm.synced_folder "../kisakone-live", "/kisakone/live"
        end

        # install common basic tools
        config.vm.provision :shell, :path => "scripts/install-basics.sh"

        # install mysql as backend
        config.vm.provision :shell, :path => "scripts/install-mysql.sh"


        if ENV['KISAKONE_NGINX']
            # use nginx + hhvm instead of apache and mod_php
            config.vm.provision :shell, :path => "scripts/install-nginx-hhvm.sh"
        else
            # by default, we use apache2 and mod_php as legacy option
            config.vm.provision :shell, :path => "scripts/install-apache.sh"
        end


        if ENV['KISAKONE_TESTS']
            # this will have access to /kisakone_local test environment after
            # you have executed "./run_tests.sh all"
            config.vm.network :forwarded_port, guest: 8081, host: 8081

            # postfix is disabled by default in development as no email is supposed to be sent
            if ENV['KISAKONE_POSTFIX']
                config.vm.provision :shell, :path => "scripts/install-postfix.sh"
            end

            # install nightwatch and selenium for running browser based ui tests
            config.vm.provision :shell, :path => "scripts/install-nodejs.sh"
            config.vm.provision :shell, :path => "scripts/install-test-env.sh"
        end

        # install default config and restore backup if present
        config.vm.provision :shell, :path => "scripts/configure.sh"
    end
end
