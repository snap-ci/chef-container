directory "/var/go/.bundle" do
  recursive true
  owner 'go'
  group 'go'
  mode  '0755'
end

directory "/var/go/.docker" do
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
  source "gitconfig"
  owner 'go'
  group 'go'
  mode '0644'
end
