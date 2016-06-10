# chef-pulledpork Cookbook CHANGELOG

This file is used to list changes made in each version of the pulledpork cookbook.

## v2.0.0 (2016-06-10)

- Broke out the default recipe into parts that are easier to consume in wrapper cookbooks
- Added support for RHEL
- Added Debian as a supported platform
- Added a basic convergence chefspec
- Fixed the source_url and issues_url metadata URLs
- Added a Rakefile for simplified testing
- Added a contributing doc
- Updated all testing deps in the Gemfile
- Add maintainers files
- Switched integration testing to kitchen-dokken in travis
- Switched from Rubocop to Cookstyle which wraps Rubocop with a preset rule list
