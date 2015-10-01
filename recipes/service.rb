

cron 'pulledpork' do
  hour '12'
  minute '0'
  command "/usr/local/bin/pulledpork.pl -c #{node['pulledpork']['pp_config_path']} -l && service #{node['pulledpork']['snort_svc_name']} restart"
end
