directory "/var/go/.bundle" do
  recursive true
  owner 'go'
  group 'go'
  mode  '0755'

  action (Dir.exist?("/var/go/.rbenv") ? :delete : :create)
end

cookbook_file "/var/go/.bundle/config" do
  source "bundle-config"
  owner 'go'
  group 'go'
  mode '0644'

  not_if { Dir.exist? ("/var/go/.rbenv") }
end

cookbook_file "/var/go/.gitconfig" do
  source "gitconfig"
  owner 'go'
  group 'go'
  mode '0644'
end
