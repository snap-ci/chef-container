group "git" do
  gid 1025
end

user "git" do
  home    "/var/lib/git"
  shell   "/bin/bash"
  comment "Git Proxy User"
  group   "git"
  uid     1025
  supports ({ :manage_home => true })
end

directory '/var/lib/git' do
  owner 'git'
  group 'git'
  mode '0700'
end

directory "/var/lib/git/.ssh" do
  owner "git"
  group "git"
  mode "0700"
end

cookbook_file "/var/lib/git/.ssh/config" do
  owner "git"
  group "git"
  mode  "0400"
  source "ssh_config"
end
