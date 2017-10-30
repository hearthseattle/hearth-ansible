# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
if File.exist? File.expand_path 'vagrant_settings.yml'
  cfg = YAML.load_file 'vagrant_settings.yml'
else
  cfg = YAML.load_file 'vagrant_settings.example.yml'
end

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  config.vm.box = 'ubuntu/xenial64'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network 'forwarded_port', guest: 80, host: 8001
  config.vm.network 'forwarded_port', guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder cfg['hearth_dir'], "/var/www/hearth/homeless_to_hearth", mount_options: ["uid=1234"]

  config.vm.provider 'virtualbox' do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = '1024'
    vb.name = 'hearth'
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'ansible' do |ansible|
    ansible.playbook = 'playbooks/local.yml'
    ansible.raw_arguments = []
  end

  # Place profile with aliases
  config.vm.provision 'file', source: 'profile', destination: '/home/ubuntu/.profile'
end
