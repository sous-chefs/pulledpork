# frozen_string_literal: true

require 'shellwords'

provides :pulledpork_cron
unified_mode true

include Pulledpork::Cookbook::Helpers

property :config_path, String,
          default: '/etc/snort/pulledpork.conf',
          description: 'Path to pulledpork.conf'

property :executable_path, String,
          default: '/usr/local/bin/pulledpork.pl',
          description: 'Path to the installed PulledPork executable'

property :snort_service_name, String,
          default: lazy { default_snort_service_name },
          description: 'Snort service to restart after PulledPork updates'

property :hour, [String, Integer],
          default: '12',
          description: 'Cron hour'

property :minute, [String, Integer],
          default: '0',
          description: 'Cron minute'

action_class do
  include Pulledpork::Cookbook::Helpers
end

action :create do
  cron new_resource.name do
    hour new_resource.hour.to_s
    minute new_resource.minute.to_s
    update = [new_resource.executable_path, '-c', new_resource.config_path, '-l'].shelljoin
    restart = ['service', new_resource.snort_service_name, 'restart'].shelljoin
    command "#{update} && #{restart}"
  end
end

action :delete do
  cron new_resource.name do
    action :delete
  end
end
