#
# Cookbook Name:: pulledpork
# Attributes:: default
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

default['pulledpork']['version'] = '0.7.0'
default['pulledpork']['artifact_url'] = 'https://pulledpork.googlecode.com/files/pulledpork-0.7.0.tar.gz'

# without any rule_urls defined in this array pulled pork will fail to run
default['pulledpork']['rule_url_array'] = []

default['pulledpork']['ignore'] = 'deleted.rules,experimental.rules,local.rules'
default['pulledpork']['temp_path'] = '/tmp'
default['pulledpork']['rule_path'] = '/etc/snort/rules/snort.rules'
default['pulledpork']['sid_msg'] = '/etc/snort/sid-msg.map'
default['pulledpork']['sid_msg_version'] = 1
default['pulledpork']['sid_changelog'] = '/var/log/snort/sid_changes.log'
default['pulledpork']['snort_path'] = '/usr/sbin/snort'
default['pulledpork']['config_path'] = '/etc/snort/snort.conf'
default['pulledpork']['sorule_path'] = '/usr/lib/snort_dynamicrules/'
default['pulledpork']['distro'] = 'Ubuntu-10-4'
default['pulledpork']['black_list'] = '/etc/snort/rules/iplists/default.blacklist'
default['pulledpork']['IPRVersion'] = '/etc/snort/rules/iplists'
