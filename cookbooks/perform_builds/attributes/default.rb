go_data_dirs = {
  '/var/lib/go-server' => {:owner => :go, :group  => :go, :mode  => "0755"},
  '/var/lib/go-server/artifacts' => {:owner => :go, :group  => :go, :mode  => "0755"}
}

docker_dir = {
  '/var/lib/docker' => {:owner => :root, :group => :root, :mode => "0700"}
}

git_proxy_dirs = {
  '/var/lib/git'                                 => {:owner => :git, :group => :git, :mode => "0700"},
  '/var/lib/git/.ssh'                            => {:owner => :git, :group => :git, :mode => "0700"},
}

# these live after the build completes
default[:perform_builds][:project_dirs] = go_data_dirs.merge(git_proxy_dirs).merge(docker_dir)

# these are ephemeral, will be removed by container snapshot
default[:perform_builds][:container_dirs] = {
  '/var/go' => {:owner => :go, :group => :go, :mode => "0750"},
  '/var/go/.ssh' => {:owner => :go, :group => :go, :mode => "0755"},
  '/var/snap-ci' => {:owner => :go, :group => :go, :mode => "0750"},
}
