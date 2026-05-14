# frozen_string_literal: true

provides :pulledpork_install
unified_mode true

include Pulledpork::Cookbook::Helpers

property :version, String,
          default: '0.7.3',
          description: 'PulledPork version to install'

property :artifact_url, String,
          default: lazy { "https://github.com/shirkdog/pulledpork/archive/#{version}.tar.gz" },
          description: 'Source archive URL'

property :dependencies, Array,
          default: lazy { default_pulledpork_dependencies },
          description: 'Packages required to run PulledPork'

property :install_path, String,
          default: lazy { "/usr/local/pulledpork-#{version}" },
          description: 'Versioned install path'

property :prefix_root, String,
          default: '/usr/local',
          description: 'Root path for ark installation'

property :prefix_bin, String,
          default: '/usr/local/bin',
          description: 'Directory where pulledpork.pl is linked'

property :backup, [false, Integer],
          default: 5,
          description: 'Remote file backup count for the downloaded archive'

action_class do
  include Pulledpork::Cookbook::Helpers
end

action :install do
  raise "The platform #{node['platform']} is not supported by pulledpork_install" if new_resource.dependencies.nil?

  package new_resource.dependencies

  ark 'pulledpork' do
    url new_resource.artifact_url
    version new_resource.version
    prefix_root new_resource.prefix_root
    prefix_bin new_resource.prefix_bin
    has_binaries %w(pulledpork.pl)
    backup new_resource.backup
  end

  file ::File.join(new_resource.install_path, 'pulledpork.pl') do
    mode '0755'
  end
end

action :remove do
  link ::File.join(new_resource.prefix_root, 'pulledpork') do
    action :delete
  end

  link ::File.join(new_resource.prefix_bin, 'pulledpork.pl') do
    action :delete
  end

  directory new_resource.install_path do
    recursive true
    action :delete
  end
end
