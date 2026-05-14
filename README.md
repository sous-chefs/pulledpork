# pulledpork

[![Cookbook Version](https://img.shields.io/cookbook/v/pulledpork.svg)](https://supermarket.chef.io/cookbooks/pulledpork)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Chef cookbook with custom resources for installing and configuring the Snort ruleset update utility Pulled Pork.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

See [LIMITATIONS.md](LIMITATIONS.md) for current platform and package support.

### Chef

- Chef 15.3+

### Cookbooks

- ark

## Resources

- [pulledpork_install](documentation/pulledpork_install.md)
- [pulledpork_config](documentation/pulledpork_config.md)
- [pulledpork_cron](documentation/pulledpork_cron.md)

## Migration

See [migration.md](migration.md) for the breaking change from recipes and node attributes to custom resources.

## Usage

Before this cookbook can run you must have a working copy of Snort. The default resource properties assume the snort paths from a package install as done in the snort cookbook. If you install via source, set the matching `pulledpork_config` properties to the source paths.

You will need to set at least one rule URL for PulledPork to run. The default is empty to give full control over the rules you run.

```ruby
pulledpork_install 'default'

pulledpork_config '/etc/snort/pulledpork.conf' do
  rule_urls ['https://snort.org/downloads/community/|community-rules.tar.gz|Community']
end

pulledpork_cron 'pulledpork'
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
