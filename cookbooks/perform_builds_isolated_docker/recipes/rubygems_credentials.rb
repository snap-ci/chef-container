if node.project.rubygems
  directory "/var/go/.gem" do
    owner "go"
    group "go"
    mode "0755"
  end

  template "/var/go/.gem/credentials" do
    source "gem_credentials.erb"
    owner "go"
    group "go"
    mode "0600"
  end
end