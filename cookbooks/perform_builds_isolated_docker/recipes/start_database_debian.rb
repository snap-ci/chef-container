database = node.project[:database]

execute 'service postgresql stop'
if database
  case database
    when 'postgresql'
      execute 'service postgresql start 9.2'
      link '/usr/bin/pg_config' do
        to '/usr/bin/pg_config-92'
      end
    when 'postgresql93'
      execute 'service postgresql start 9.3'
      link '/usr/bin/pg_config' do
        to '/usr/bin/pg_config-93'
      end
    when 'postgresql94'
      execute 'service postgresql start 9.4'
      link '/usr/bin/pg_config' do
        to '/usr/bin/pg_config-94'
      end
    when 'mysql'
      service 'mysql' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Upstart
      end
  end
end
