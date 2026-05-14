# Migration

## Migrating from recipes and attributes

This release removes the legacy `pulledpork::default`, `pulledpork::install`,
`pulledpork::configure`, and `pulledpork::service` recipes. It also removes the
`node['pulledpork']` attribute API.

Use custom resources in your own wrapper cookbook instead:

```ruby
pulledpork_install 'default'

pulledpork_config '/etc/snort/pulledpork.conf' do
  rule_urls ['https://snort.org/downloads/community/|community-rules.tar.gz|Community']
  run_on_update true
end

pulledpork_cron 'pulledpork'
```

## Attribute mapping

| Legacy attribute                                      | Resource property                                                         |
| ----------------------------------------------------- | ------------------------------------------------------------------------- |
| `node['pulledpork']['version']`                       | `pulledpork_install.version`, `pulledpork_config.pulledpork_version`      |
| `node['pulledpork']['dependencies']`                  | `pulledpork_install.dependencies`                                         |
| `node['pulledpork']['artifact_url']`                  | `pulledpork_install.artifact_url`                                         |
| `node['pulledpork']['pp_config_path']`                | `pulledpork_config.config_path`, `pulledpork_cron.config_path`            |
| `node['pulledpork']['rule_url_array']`                | `pulledpork_config.rule_urls`                                             |
| `node['pulledpork']['disabled_sids_hash_array']`      | `pulledpork_config.disabled_sids`                                         |
| `node['pulledpork']['snort_svc_name']`                | `snort_service_name` on config and cron resources                         |
| Other config attributes                               | Matching `pulledpork_config` properties                                   |

The `test/cookbooks/test/recipes/default.rb` recipe shows the supported resource-based usage.
