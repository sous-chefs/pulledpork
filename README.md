# chef-pulledpork

[![Build Status](https://travis-ci.org/tas50/chef-pulledpork.svg?branch=master)](https://travis-ci.org/tas50/chef-pulledpork) [![Cookbook Version](https://img.shields.io/cookbook/v/pulledpork.svg)](https://supermarket.chef.io/cookbooks/pulledpork)

Chef cookbook for installing the Snort ruleset update utility Pulled Pork

## Requirements

### Platforms

- Ubuntu 12.04+
- Debian 7+
- RHEL 6+

### Chef

- Chef 11+

### Cookbooks

- ark

## Usage

Before this cookbook can run you must have a working copy of Snort. The default attributes of this cookbook assume the snort paths from a package install as done in the snort cookbook. If you install via source you'll want to set these attributes to the source paths.

You will need to set the rule_url_array attribute for pulledpork to run. The attribute defaults to nil to give full control over the rules you run. The Kitchen CI setup uses '<https://s3.amazonaws.com/snort-org/www/rules/community/|community-rules.tar.gz|Community>' which provides open source community rules.

## License & Authors

**Author:** Tim Smith ([tsmith84@gmail.com](mailto:tsmith84@gmail.com))

**Copyright:** 2015-2016, Tim Smith

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
