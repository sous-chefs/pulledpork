# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')

pulledpork_install 'default'

pulledpork_config '/etc/snort/pulledpork.conf' do
  rule_urls ['https://snort.org/downloads/community/|community-rules.tar.gz|Community']
  run_on_update false
end

pulledpork_cron 'pulledpork'
