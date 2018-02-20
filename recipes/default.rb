#
# Cookbook Name:: pulledpork
# Recipe:: default
#
# Copyright:: 2015-2018, Tim Smith
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

include_recipe 'pulledpork::install'
include_recipe 'pulledpork::configure'

# for notification
service node['pulledpork']['snort_svc_name'] do
  action :nothing
end

# one time pulled pork run for first install / config changes
execute 'run_pulledpork' do
  command "/usr/local/bin/pulledpork.pl -c #{node['pulledpork']['pp_config_path']} -l"
  action :nothing
  notifies :restart, "service[#{node['pulledpork']['snort_svc_name']}]", :immediately
end

# This is really just a cron job
include_recipe 'pulledpork::service'
