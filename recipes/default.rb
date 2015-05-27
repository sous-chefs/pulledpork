#
# Cookbook Name:: pulledpork
# Recipe:: default
#
# Copyright (c) 2015, Tim Smith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install packages needed by pulledpork
package %w(libcrypt-ssleay-perl liblwp-useragent-determined-perl)

ark 'pulledpork' do
  url node['pulledpork']['artifact_url']
  version node['pulledpork']['version']
  has_binaries %w(pulledpork.pl)
end

# fix bad permissions in the tarball
file "/usr/local/pulledpork-#{node['pulledpork']['version']}/pulledpork.pl" do
  mode '0755'
end

template '/etc/snort/pulledpork.conf' do
  source 'pulledpork.conf.erb'
  owner 'root'
  group 'root'
  mode '0640'
  notifies :run, 'execute[run_pulledpork]'
end

cron 'pulledpork' do
  hour '12'
  minute '0'
  command '/usr/local/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l'
end

# create the sorule_path unless its managed elsewhere
directory node['pulledpork']['sorule_path'] do
  owner 'root'
  group 'root'
  mode '0755'
  not_if { ::File.exist?(node['pulledpork']['sorule_path']) }
end

# pulled pork fails if a so rule doesn't exist in the dir.
cookbook_file '/usr/lib/snort_dynamicrules/os-linux.so' do
  source 'default_so_rule'
  action :create_if_missing
  owner 'root'
  group 'root'
  mode '0655'
end

# one time pulled pork run for first install / config changes
execute 'run_pulledpork' do
  command '/usr/local/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l'
  action :nothing
end
