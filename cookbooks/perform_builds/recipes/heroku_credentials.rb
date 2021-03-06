if project = node[:project]
  go_home = "/var/go"
  if heroku = node.project[:heroku]
    template "#{go_home}/.netrc" do
      source "netrc.erb"
      mode "0600"
      owner "go"
      group "go"
    end
  else
    ["#{go_home}/.netrc", "#{go_home}/.ssh/id_rsa_heroku"].each do |unused_file|
      execute "removing #{unused_file}" do
        command "rm -rf #{unused_file}"
      end
    end
  end
end
