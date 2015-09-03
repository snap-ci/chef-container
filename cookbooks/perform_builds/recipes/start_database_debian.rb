database = node.project[:database]

if database
  case database
    when 'postgresql'
      execute 'service postgresql start 9.2'
    when 'postgresql93'
      execute 'service postgresql start 9.3'
    when 'postgresql94'
      execute 'service postgresql start 9.4'
    when 'mysql'
      service 'mysql' do
        action [:start]
        retries 3
        provider Chef::Provider::Service::Upstart
      end
  end
end
