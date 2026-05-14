# frozen_string_literal: true

provides :pulledpork_cron
unified_mode true

include Pulledpork::Cookbook::Helpers

property :config_path, String,
          default: '/etc/snort/pulledpork.conf',
          description: 'Path to pulledpork.conf'

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
    command "/usr/local/bin/pulledpork.pl -c #{new_resource.config_path} -l && service #{new_resource.snort_service_name} restart"
  end
end

action :delete do
  cron new_resource.name do
    action :delete
  end
end
