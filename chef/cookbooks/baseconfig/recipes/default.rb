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

#execute "project_dependency_install" do
#  cwd "/home/ubuntu/project/webroot"
#  user "ubuntu"
#  environment ({'HOME' => '/home/ubuntu', 'USER' => 'ubuntu'})
#  command "npm install --no-bin-links --verbose"
#end
