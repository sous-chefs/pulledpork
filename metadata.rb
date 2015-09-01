name             'pulledpork'
maintainer       'Tim Smith'
maintainer_email 'tsmith84@gmail.com'
license          'Apache 2.0'
description      'Installs and Configures the Snort IDS ruleset updater Pulled Pork'
version          '1.1.1'

supports 'debian', '>= 7'
supports 'ubuntu', '>= 10.04'
depends 'ark'

source_url 'https://github.com/tas50/chef-pulledpork' if respond_to?(:source_url)
issues_url 'https://github.com/tas50/chef-pulledpork/issues' if respond_to?(:issues_url)
