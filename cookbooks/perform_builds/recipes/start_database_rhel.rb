database = node.project[:database]

if database
  case database
    when 'postgresql'
      link '/usr/local/bin/pg_config' do
        to '/usr/local/bin/pg_config-92'
      end

      service 'postgresql-9.2' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Redhat
      end
    when 'postgresql93'
      link '/usr/local/bin/pg_config' do
        to '/usr/local/bin/pg_config-93'
      end

      service 'postgresql-9.3' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Redhat
      end
    when 'postgresql94'
      link '/usr/local/bin/pg_config' do
        to '/usr/local/bin/pg_config-94'
      end

      service 'postgresql-9.4' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Redhat
      end
    when 'postgresql95'
      link '/usr/local/bin/pg_config' do
        to '/usr/local/bin/pg_config-95'
      end

      service 'postgresql-9.5' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Redhat
      end
    when 'mysql'
      service 'mysqld' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Redhat
      end
  end
end
