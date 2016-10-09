# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute "apt_update" do
  command "apt-get update"
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute "ntp_restart" do
  command "service ntp restart"
end

# nvm is a dependency for installing nodejs
execute "nvm_install" do
  command "curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | NVM_DIR=/home/ubuntu/nvm bash"
  not_if { ::File.exist?('/home/ubuntu/nvm/nvm.sh') }
end
file 'nvmlock_create' do
  owner 'ubuntu'
  action :create_if_missing
  path '/home/ubuntu/nvm/nvm.lock'
end
# bash_profile loads on login and allow access to nvm commands
file '/home/ubuntu/.bash_profile' do
  content <<-EOH
    export NVM_DIR=/home/ubuntu/nvm
    [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh
  EOH
  owner 'ubuntu'
  action :create
end
# Install stable version of nodejs (ember-cli dependency)
execute "nodejs_install" do
  user 'ubuntu'
  environment ({ 'HOME' => '/home/ubuntu', 'USER' => 'ubuntu' })
  command "nvm install stable"
end
# npm is required for installing ember-cli
##package "npm"
##execute "ember-cli_install" do
##  command "npm install -g ember-cli"
##end
