# pulledpork_config

Renders PulledPork configuration files and prepares the Snort shared object rule directory.

## Actions

| Action    | Description                                        |
| --------- | -------------------------------------------------- |
| `:create` | Creates PulledPork configuration.                  |
| `:delete` | Removes PulledPork-managed configuration files.    |

## Properties

| Property              | Type        | Default                                          | Description                                      |
| --------------------- | ----------- | ------------------------------------------------ | ------------------------------------------------ |
| `config_path`         | String      | name property                                    | Path to `pulledpork.conf`.                       |
| `rule_urls`           | Array       | `[]`                                             | PulledPork `rule_url` entries.                   |
| `disabled_sids`       | Array       | `[]`                                             | Array of disabled SID hashes.                    |
| `ignore`              | String      | `'deleted.rules,experimental.rules,local.rules'` | PulledPork ignore setting.                       |
| `temp_path`           | String      | `'/tmp'`                                         | Temporary path.                                  |
| `rule_path`           | String      | `'/etc/snort/rules/snort.rules'`                 | Generated Snort rules file.                      |
| `sid_msg`             | String      | `'/etc/snort/sid-msg.map'`                       | SID message map path.                            |
| `sid_msg_version`     | Integer     | `1`                                              | SID message map version.                         |
| `sid_changelog`       | String      | `'/var/log/snort/sid_changes.log'`               | SID changelog path.                              |
| `snort_path`          | String      | `'/usr/sbin/snort'`                              | Snort executable path.                           |
| `snort_config_path`   | String      | `'/etc/snort/snort.conf'`                        | Snort configuration path.                        |
| `sorule_path`         | String      | `'/usr/lib/snort_dynamicrules/'`                 | Shared object rule directory.                    |
| `distro`              | String      | `''`                                             | PulledPork distro setting.                       |
| `black_list`          | String      | `'/etc/snort/rules/iplists/default.blacklist'`   | Blacklist path.                                  |
| `ipr_version`         | String      | `'/etc/snort/rules/iplists'`                     | IP reputation version path.                      |
| `pulledpork_version`  | String      | `'0.7.3'`                                        | Snort rules version setting used by PulledPork.  |
| `disablesid_path`     | String      | `'/etc/snort/disablesid.conf'`                   | Disabled SID file path.                          |
| `snort_service_name`  | String      | Platform dependent                               | Snort service to restart after updates.          |
| `run_on_update`       | true, false | `true`                                           | Run `pulledpork.pl` when configuration changes.  |

## Examples

```ruby
pulledpork_config '/etc/snort/pulledpork.conf' do
  rule_urls ['https://snort.org/downloads/community/|community-rules.tar.gz|Community']
end
```

```ruby
pulledpork_config '/etc/snort/pulledpork.conf' do
  disabled_sids [{ '129:4:1' => 'TCP Timestamp is outside of PAWS window' }]
  run_on_update false
end
```
