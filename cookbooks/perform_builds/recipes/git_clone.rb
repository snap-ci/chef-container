git_repository_organization_name, git_repository_name = node.project.git.repository_full_name.split('/')
git_home_directory = "/var/lib/git"

git_repository_organization_name_path = ::File.join(git_home_directory, git_repository_organization_name)
directory git_repository_organization_name_path do
  owner "git"
  group "git"
  mode "0755"
  recursive true
end

git_clone_path = ::File.join(git_repository_organization_name_path, git_repository_name)
directory git_clone_path do
  owner "git"
  group "git"
  mode "0755"
  recursive true
end

execute "perform_git_clone" do
  command "git clone --depth 50 --mirror #{node.project.git.clone_url} #{git_clone_path}"
  user "git"
  group "git"

  retry_delay 5
  retries     10

  creates ::File.join(git_clone_path, 'HEAD')
end

execute "perform_git_sync" do
  command "git fetch --depth 50 --prune --all"
  cwd git_clone_path
  user "git"
  group "git"

  retry_delay 5
  retries     10

  notifies :delete, 'file[/tmp/id_rsa_github]' unless node.project.not_pull_request
end

cookbook_file "#{git_home_directory}/.gitconfig" do
  source "git_user_gitconfig"
  owner "git"
  group "git"
  mode "0640"
end

git_hooks = {
  "git_update" => "#{git_clone_path}/hooks/update",
  "git_post-receive" => "#{git_clone_path}/hooks/post-receive"
}

git_hooks.each do |name, path|
  cookbook_file path do
    source name
    owner "git"
    group "git"
    mode "0755"
  end
end
