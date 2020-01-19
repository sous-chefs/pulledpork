# chef-pulledpork Cookbook CHANGELOG

This file is used to list changes made in each version of the pulledpork cookbook.

## Unreleased

- Fix restarts of snort under systemd
- Use pulledpork 0.7.3 now
- Migrate the maintainer of this cookbook to Sous Chefs
- Add CircleCI and Danger (#3)
- Update community rules URL for testing
- Switch to delivery local mode for testing
- Switch integration testing from kitchen-docker to kitchen-dokken
- Add a code of conduct file
- Avoid ChefSpec deprecation warnings
- Move templates out of default dir
- Move templates out of default dir
- Update testing for the new snort cookbook
- Simplify the install
- Migrate to actions

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
