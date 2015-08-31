directory "/var/go/.ssh" do
  mode "0755"
  owner "go"
  group "go"
  recursive true
end

cookbook_file "/var/go/.ssh/config" do
  source "go_user_ssh_config"
  mode "0600"
  owner "go"
  group "go"
end

file "/tmp/id_rsa_github" do
  owner "git"
  group "git"
  mode "0400"
  content node.project.git.ssh_private_key
end

execute "generate ssh key for go user" do
  command "yes | ssh-keygen -t rsa -f /var/go/.ssh/id_rsa_git_proxy -N ''"
  user  "go"
  group "go"
  creates "/var/go/.ssh/id_rsa_git_proxy"
end

ruby_block "copy-proxy-public-key" do
  block do
    File.open('/var/lib/git/.ssh/authorized_keys', 'a') do |f|
      f.puts "command=\"perl -e 'exec qw(git-shell -c), $ENV{SSH_ORIGINAL_COMMAND}'\",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty #{File.read('/var/go/.ssh/id_rsa_git_proxy.pub')}"
    end
  end
end

file "/var/lib/git/.ssh/authorized_keys" do
  owner "git"
  group "git"
  mode  "0400"
end
