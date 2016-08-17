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
