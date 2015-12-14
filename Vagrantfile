# -*- mode: ruby -*-
# vi: set ft=ruby :
# Author: Tuomo Tanskanen <tuomo@tanskanen.org>

Vagrant.configure("2") do |config|

  config.vm.define :kisakone do |config|
    # Virtualbox box
    config.vm.provider "virtualbox" do |v, override|
      override.vm.box = "hashicorp/precise64"
      v.memory = 2048
    end

    # LXC
    config.vm.provider "lxc" do |v, override|
      override.vm.box = "fgrehm/precise64-lxc"
    end

    # vmware
    config.vm.provider "vmware_fusion" do |v, override|
      override.vm.box = "hashicorp/precise64"
      v.vmx["memsize"] = "2048"
    end

    # parallels
    config.vm.provider "parallels" do |v, override|
      override.vm.box = "parallels/ubuntu-12.04"
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

    if ENV['TESTENV']
      # this will have access to /kisakone_local test environment after
      # you have executed "./run_tests.sh all"
      config.vm.network :forwarded_port, guest: 8081, host: 8081

      # install unittest framework
      config.vm.provision :shell, :path => "scripts/install-phpunit.sh"

      # install nightwatch and selenium for running browser based ui tests
      config.vm.provision :shell, :path => "scripts/install-nodejs.sh"
      config.vm.provision :shell, :path => "scripts/install-test-env.sh"
    end

    # install default config and restore backup if present
    config.vm.provision :shell, :path => "scripts/configure.sh"
  end
end
