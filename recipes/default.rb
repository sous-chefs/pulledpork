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

include_recipe 'pulledpork::install'
include_recipe 'pulledpork::configure'

# one time pulled pork run for first install / config changes
bash 'run_pulledpork' do
  code <<-EOH
  /usr/local/bin/pulledpork.pl -c #{node['pulledpork']['pp_config_path']} -l;
  service #{node['pulledpork']['snort_svc_name']} restart
  EOH
  action :nothing
end

# This is really just a cron job
include_recipe 'pulledpork::service'
