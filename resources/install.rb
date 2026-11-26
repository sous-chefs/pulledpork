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
          default: lazy { ::File.join(prefix_root, "pulledpork-#{version}") },
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

  def points_to?(link_path, target_path)
    ::File.expand_path(::File.readlink(link_path), ::File.dirname(link_path)) == ::File.expand_path(target_path)
  rescue Errno::ENOENT, Errno::EINVAL
    false
  end
end

action :install do
  raise "The platform #{node['platform']} is not supported by pulledpork_install" if new_resource.dependencies.nil?

  yum_epel 'default' if platform_family?('rhel')
  package new_resource.dependencies

  [new_resource.prefix_root, new_resource.prefix_bin].uniq.each do |path|
    directory path do
      recursive true
    end
  end

  ark 'pulledpork' do
    url new_resource.artifact_url
    version new_resource.version
    path new_resource.install_path
    prefix_root new_resource.prefix_root
    prefix_home new_resource.prefix_root
    prefix_bin new_resource.prefix_bin
    has_binaries %w(pulledpork.pl)
    backup new_resource.backup
  end

  file ::File.join(new_resource.install_path, 'pulledpork.pl') do
    mode '0755'
  end
end

action :remove do
  home_link = ::File.join(new_resource.prefix_root, 'pulledpork')
  bin_link = ::File.join(new_resource.prefix_bin, 'pulledpork.pl')
  executable = ::File.join(new_resource.install_path, 'pulledpork.pl')

  link home_link do
    action :delete
    only_if { points_to?(home_link, new_resource.install_path) }
  end

  link bin_link do
    action :delete
    only_if { points_to?(bin_link, executable) }
  end

  directory new_resource.install_path do
    recursive true
    action :delete
  end
end
