# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppetlabs-centos64"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  config.vm.network : forwarded_port, guest:80, host: 8888
  # This means that you should be able to access the Drupal site at
  # http://localhost:8888/ once the Vagrant box boots and provisioning
  # is complete.
  config.vm.network :public_network

  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1536"]
  end

  # group { "puppet":
  #   ensure => "present",
  # }
  #
  # File { owner => 0, group => 0, mode => 0644 }
  #
  # file { '/etc/motd':
  #   content => "Welcome to your Vagrant-built virtual machine!
  #               Managed by Puppet.\n"
  # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

end
