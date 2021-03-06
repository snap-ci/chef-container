dirs = node.perform_builds.project_dirs.keys.sort.uniq

dirs.each do |dir|
  perms = node.perform_builds.project_dirs[dir]

  [dir, ::File.join("/projectdata", dir)].each do |d|
    directory d do
      recursive true
      owner perms[:owner].to_s
      group perms[:group].to_s
      mode  perms[:mode].to_s
    end
  end

  mount dir do
    device  ::File.join("/projectdata", dir)
    fstype  'none'
    action  [:mount]
    options 'bind,rw'
  end
end

node.perform_builds.container_dirs.each do |name, perms|
  directory name do
    recursive true
    owner perms[:owner].to_s
    group perms[:group].to_s
    mode  perms[:mode].to_s
  end
end

docker_dir = "/var/lib/docker"
perms = node.perform_builds.docker_dir[docker_dir]

directory docker_dir do
  recursive true
  owner perms[:owner].to_s
  group perms[:group].to_s
  mode  perms[:mode].to_s
end

directory ::File.join("/projectdata", "#{node.pipeline}", docker_dir) do
  recursive true
  owner perms[:owner].to_s
  group perms[:group].to_s
  mode perms[:mode].to_s
end

mount docker_dir do
  device  ::File.join("/projectdata", "#{node.pipeline}", docker_dir)
  fstype  'none'
  action  [:mount]
  options 'bind,rw'
end

include_recipe 'git_user'
include_recipe 'perform_builds::setup_ssh'
include_recipe 'perform_builds::git_clone'
include_recipe 'perform_builds::heroku_credentials'
include_recipe 'perform_builds::rubygems_credentials'
include_recipe 'perform_builds::dot_files'
include_recipe 'perform_builds::hot_fixes'

if node[:platform_family] == 'rhel'
  include_recipe 'perform_builds::setup_audio_device'
  include_recipe 'perform_builds::start_database_rhel'
else
  include_recipe 'perform_builds::start_database_debian'
  service 'docker' do
    action [:restart]
    provider Chef::Provider::Service::Upstart
  end
end
include_recipe 'perform_builds::setup_repository_mirror' if node['repositories_base_url']

service 'xvfb' do
  action [:start]
end
