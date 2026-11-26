# frozen_string_literal: true

provides :pulledpork_config
unified_mode true

include Pulledpork::Cookbook::Helpers

property :config_path, String,
          name_property: true,
          description: 'Path to pulledpork.conf'

property :executable_path, String,
          default: '/usr/local/bin/pulledpork.pl',
          description: 'Path to the installed PulledPork executable'

property :rule_urls, Array,
          default: [],
          description: 'PulledPork rule_url entries'

property :disabled_sids, Array,
          default: [],
          description: 'Array of disabled SID hashes'

property :ignore, String,
          default: 'deleted.rules,experimental.rules,local.rules',
          description: 'PulledPork ignore setting'

property :temp_path, String,
          default: '/tmp',
          description: 'Temporary path'

property :rule_path, String,
          default: '/etc/snort/rules/snort.rules',
          description: 'Generated Snort rules file'

property :sid_msg, String,
          default: '/etc/snort/sid-msg.map',
          description: 'SID message map path'

property :sid_msg_version, Integer,
          default: 1,
          description: 'SID message map version'

property :sid_changelog, String,
          default: '/var/log/snort/sid_changes.log',
          description: 'SID changelog path'

property :snort_path, String,
          default: '/usr/sbin/snort',
          description: 'Snort executable path'

property :snort_config_path, String,
          default: '/etc/snort/snort.conf',
          description: 'Snort configuration path'

property :sorule_path, String,
          default: '/usr/lib/snort_dynamicrules/',
          description: 'Shared object rule directory'

property :distro, String,
          default: '',
          description: 'PulledPork distro setting'

property :black_list, String,
          default: '/etc/snort/rules/iplists/default.blacklist',
          description: 'Blacklist path'

property :ipr_version, String,
          default: '/etc/snort/rules/iplists',
          description: 'IP reputation version path'

property :pulledpork_version, String,
          default: '0.7.3',
          description: 'Snort rules version setting used by PulledPork'

property :disablesid_path, String,
          default: '/etc/snort/disablesid.conf',
          description: 'Disabled SID file path'

property :snort_service_name, String,
          default: lazy { default_snort_service_name },
          description: 'Snort service to restart after PulledPork updates'

property :run_on_update, [true, false],
          default: true,
          desired_state: false,
          description: 'Run pulledpork.pl when configuration changes'

action_class do
  include Pulledpork::Cookbook::Helpers
end

action :create do
  paths = [new_resource.config_path, new_resource.rule_path, new_resource.black_list, new_resource.sid_changelog]
  paths.map { |path| ::File.dirname(path) }.push(new_resource.sorule_path).uniq.each do |path|
    directory path do
      recursive true
      mode '0755'
      not_if { ::File.directory?(path) }
    end
  end

  service new_resource.snort_service_name do
    action :nothing
  end

  execute 'run_pulledpork' do
    command [new_resource.executable_path, '-c', new_resource.config_path, '-l']
    action :nothing
    only_if { new_resource.run_on_update && !new_resource.rule_urls.empty? }
    notifies :restart, "service[#{new_resource.snort_service_name}]", :immediately
  end

  template new_resource.disablesid_path do
    cookbook 'pulledpork'
    source 'disablesid.conf.erb'
    mode '0640'
    variables(disabled_sids: new_resource.disabled_sids)
    notifies :run, 'execute[run_pulledpork]'
    not_if { new_resource.disabled_sids.empty? }
  end

  template new_resource.config_path do
    cookbook 'pulledpork'
    source 'pulledpork.conf.erb'
    mode '0640'
    variables(
      rule_urls: new_resource.rule_urls,
      ignore: new_resource.ignore,
      temp_path: new_resource.temp_path,
      rule_path: new_resource.rule_path,
      sid_msg: new_resource.sid_msg,
      sid_msg_version: new_resource.sid_msg_version,
      sid_changelog: new_resource.sid_changelog,
      snort_path: new_resource.snort_path,
      snort_config_path: new_resource.snort_config_path,
      sorule_path: new_resource.sorule_path,
      distro: new_resource.distro,
      black_list: new_resource.black_list,
      ipr_version: new_resource.ipr_version,
      pulledpork_version: new_resource.pulledpork_version,
      disablesid_path: new_resource.disablesid_path,
      disabled_sids: new_resource.disabled_sids
    )
    notifies :run, 'execute[run_pulledpork]'
  end

  cookbook_file ::File.join(new_resource.sorule_path, 'os-linux.so') do
    cookbook 'pulledpork'
    source 'default_so_rule'
    action :create_if_missing
    mode '0655'
  end
end

action :delete do
  file new_resource.disablesid_path do
    action :delete
    not_if { new_resource.disabled_sids.empty? }
  end

  file new_resource.config_path do
    action :delete
  end
end
