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
case node['platform_family']
when 'debian'
  default['pulledpork']['dependencies'] = %w(libcrypt-ssleay-perl liblwp-useragent-determined-perl)
  default['pulledpork']['snort_svc_name'] = 'snort'
when 'rhel'
  default['pulledpork']['dependencies'] = %w(perl-libwww-perl perl-Crypt-SSLeay perl-Archive-Tar perl-Sys-Syslog perl-LWP-Protocol-https)
  default['pulledpork']['snort_svc_name'] = 'snortd'
end

default['pulledpork']['version'] = '0.7.2'
default['pulledpork']['pp_config_path'] = '/etc/snort/pulledpork.conf'
default['pulledpork']['artifact_url'] =
  'https://github.com/shirkdog/pulledpork/archive/' +
  node['pulledpork']['version'] + '.tar.gz'

# without any rule_urls defined in this array pulled pork will fail to run
default['pulledpork']['rule_url_array'] = [

]

# this is an array of hashes that contains the disable rule as the key and a comment as the value.
# Example [{'129:4:1' => 'TCP Timestamp is outside of PAWS window'}]
default['pulledpork']['disabled_sids_hash_array'] = []

default['pulledpork']['ignore'] = 'deleted.rules,experimental.rules,local.rules'
default['pulledpork']['temp_path'] = '/tmp'
default['pulledpork']['rule_path'] = '/etc/snort/rules/snort.rules'
default['pulledpork']['sid_msg'] = '/etc/snort/sid-msg.map'
default['pulledpork']['sid_msg_version'] = 1
default['pulledpork']['sid_changelog'] = '/var/log/snort/sid_changes.log'
default['pulledpork']['snort_path'] = '/usr/sbin/snort'
default['pulledpork']['config_path'] = '/etc/snort/snort.conf'
default['pulledpork']['sorule_path'] = '/usr/lib/snort_dynamicrules/'
default['pulledpork']['distro'] = '' # Default to empty since there are only ancient distros here
default['pulledpork']['black_list'] = '/etc/snort/rules/iplists/default.blacklist'
default['pulledpork']['IPRVersion'] = '/etc/snort/rules/iplists'
default['pulledpork']['disablesid'] = '/etc/snort/disablesid.conf'
