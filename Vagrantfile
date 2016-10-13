# -*- mode: ruby -*-
# vi: set ft=ruby :

$rootScript = <<SCRIPT
  # Include git and curl related commands here
  cd /home/ubuntu
  apt-get update
SCRIPT

$userScript = <<SCRIPT
  cd /home/ubuntu

  # Install nvm as the default 'ubuntu' user
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

  # Enable nvm without a logout/login
  export NVM_DIR="/home/ubuntu/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

  if ! command -v node >/dev/null 2>&1; then
    echo "Installing nodejs ..."
    # Install nodejs and alias
    nvm install v6.7.0
    nvm alias default 6.7.0
  fi

  if ! command -v ember >/dev/null 2>&1; then
    npm set progress=false
    # workaround to npm bug which cause it to hang
    npm install -g -verbose npm@latest
    npm update -verbose
    npm install -g -verbose bower@latest
    npm install -g -verbose ember-cli@2.6
    # set up project
    cd /home/ubuntu/project/webroot
    npm install --no-bin-links --verbose || npm install --no-bin-links --verbose
    bundle install -verbose
  fi
SCRIPT



VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_version = '>= 20160921.0.0'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 10080
  config.vm.network "forwarded_port", guest: 4200, host: 10000
  config.vm.network "forwarded_port", guest: 49152, host: 10001

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./", "/home/ubuntu/project"
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # If you need to use more than double the defaults for this course, you have
  # done something wrong.
  cpus = "1"
  memory = "1024" # MB
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", cpus, "--memory", memory]
    vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"] # speed up boot https://bugs.launchpad.net/cloud-images/+bug/1627844  
    #vb.gui = true
  end
  config.vm.provider "vmware_fusion" do |v, override|
    v.vmx["memsize"] = memory
    v.vmx["numvcpus"] = cpus
  end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "baseconfig"
  end
  
  # Shell provisioning
  config.vm.provision "shell", inline: $rootScript
  config.vm.provision "shell", inline: $userScript, privileged: false
end
