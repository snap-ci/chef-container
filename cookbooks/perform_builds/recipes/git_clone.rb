git_home = "/var/lib/git"
organization, repo = node.project.git.repository_full_name.split('/')

org_path = ::File.join(git_home, organization)
repo_path = ::File.join(org_path, repo)

directory org_path do
  owner "git"
  group "git"
  mode "700"
  recursive true
end

execute "perform_git_clone" do
  command "git clone --mirror #{node.project.git.clone_url} #{repo}"
  user "git"
  group "git"
  cwd org_path

  retry_delay 5
  retries     10

  creates ::File.join(repo_path, 'HEAD')
end

execute "ensure #{git_home} ownership" do
  command "chown -R git:git #{git_home}"
end

execute "perform_git_sync" do
  command "git fetch --prune --all"
  cwd repo_path
  user "git"
  group "git"

  retry_delay 5
  retries     10

  notifies :delete, 'file[/tmp/id_rsa_github]' unless node.project.not_pull_request
end

git_hooks = {
  "git_update" => "#{repo_path}/hooks/update",
  "git_post-receive" => "#{repo_path}/hooks/post-receive"
}

git_hooks.each do |name, path|
  cookbook_file path do
    source name
    owner "git"
    group "git"
    mode "700"
  end
end
