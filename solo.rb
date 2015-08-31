cookbook_path  File.join(File.expand_path('./', __FILE__), 'cookbooks')
role_path      File.join(File.expand_path('./', __FILE__), 'roles')
log_location   "/var/log/chef/solo.log"
ssl_verify_mode   :verify_peer

if File.exist?('/etc/pki/tls/certs/ca-bundle.crt')
  # use a more up-to-date ca bundle
  ssl_ca_file '/etc/pki/tls/certs/ca-bundle.crt'
end
