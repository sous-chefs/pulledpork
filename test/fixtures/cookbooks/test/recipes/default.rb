# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')
package(platform_family?('debian') ? 'cron' : 'cronie')

pulledpork_install 'default' do
  prefix_root '/opt/pulledpork-test'
  prefix_bin '/opt/pulledpork-test/bin'
end

pulledpork_config '/etc/snort/pulledpork.conf' do
  executable_path '/opt/pulledpork-test/bin/pulledpork.pl'
end

pulledpork_cron 'pulledpork' do
  executable_path '/opt/pulledpork-test/bin/pulledpork.pl'
end
