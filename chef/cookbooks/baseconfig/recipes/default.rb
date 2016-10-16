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

# Increase amount of inotify watchers otherwise watchman will not work properly
cookbook_file "sysctl.conf" do
  path "/etc/sysctl.conf"
  notifies :run, "execute[sysctl_refresh]", :immediate
end
execute "sysctl_refresh" do
  # Refresh with new configuration
  command "sysctl -p"
  action :nothing
end

# Set default log in directory
file "/home/ubuntu/.bashrc" do
  content "cd /home/ubuntu/project/webroot"
  action :create
end

