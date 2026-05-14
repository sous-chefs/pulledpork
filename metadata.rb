# frozen_string_literal: true

name 'pulledpork'
maintainer 'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license 'Apache-2.0'
description 'Provides custom resources for the Snort IDS ruleset updater Pulled Pork'
version '3.0.11'

supports 'almalinux', '>= 8.0'
supports 'amazon', '>= 2023.0'
supports 'centos_stream', '>= 9.0'
supports 'debian', '>= 12.0'
supports 'fedora'
supports 'oracle', '>= 8.0'
supports 'redhat', '>= 8.0'
supports 'rocky', '>= 8.0'
supports 'ubuntu', '>= 22.04'

depends 'ark'

source_url 'https://github.com/sous-chefs/pulledpork'
issues_url 'https://github.com/sous-chefs/pulledpork/issues'
chef_version '>= 15.3'
