name 'pulledpork'
maintainer 'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license 'Apache-2.0'
description 'Installs and Configures the Snort IDS ruleset updater Pulled Pork'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

supports 'debian', '>= 7.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat'
supports 'centos'
supports 'scientific'
supports 'amazon'
supports 'oracle'

depends 'ark'

source_url 'https://github.com/sous-chefs/pulledpork' if respond_to?(:source_url)
issues_url 'https://github.com/sous-chefs/pulledpork/issues' if respond_to?(:issues_url)
chef_version '>= 12.0' if respond_to?(:chef_version)
