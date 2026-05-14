# pulledpork_cron

Manages the cron job that updates Snort rules with PulledPork.

## Actions

| Action    | Description                         |
| --------- | ----------------------------------- |
| `:create` | Creates the PulledPork cron job.    |
| `:delete` | Removes the PulledPork cron job.    |

## Properties

| Property             | Type            | Default                            | Description                                    |
| -------------------- | --------------- | ---------------------------------- | ---------------------------------------------- |
| `config_path`        | String          | `'/etc/snort/pulledpork.conf'`     | Path to `pulledpork.conf`.                     |
| `snort_service_name` | String          | Platform dependent                 | Snort service to restart after updates.        |
| `hour`               | String, Integer | `'12'`                             | Cron hour.                                     |
| `minute`             | String, Integer | `'0'`                              | Cron minute.                                   |

## Examples

```ruby
pulledpork_cron 'pulledpork'
```

```ruby
pulledpork_cron 'pulledpork' do
  hour 2
  minute 30
end
```
