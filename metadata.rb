name             'pulledpork'
maintainer       'Tim Smith'
maintainer_email 'tsmith84@gmail.com'
license          'Apache 2.0'
description      'Installs and Configures the Snort IDS ruleset updater Pulled Pork'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

supports 'debian', '>= 7.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat'
supports 'centos'
supports 'scientific'
supports 'amazon'
supports 'oracle'

depends 'ark'

source_url 'https://github.com/tas50/chef-pulledpork' if respond_to?(:source_url)
issues_url 'https://github.com/tas50/chef-pulledpork/issues' if respond_to?(:issues_url)
