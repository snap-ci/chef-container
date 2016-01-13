directory "/var/go/.bundle" do
  recursive true
  owner 'go'
  group 'go'
  mode  '0755'
end

cookbook_file "/var/go/.bundle/config" do
  source "bundle-config"
  owner 'go'
  group 'go'
  mode '0644'
end

cookbook_file "/var/go/.gitconfig" do
  source "go_user_gitconfig"
  owner 'go'
  group 'go'
  mode '0644'
end
