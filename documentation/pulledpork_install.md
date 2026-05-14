# pulledpork_install

Installs PulledPork and its runtime package dependencies.

## Actions

| Action     | Description                                |
| ---------- | ------------------------------------------ |
| `:install` | Installs dependencies and PulledPork.      |
| `:remove`  | Removes PulledPork files and symlinks.     |

## Properties

| Property       | Type           | Default                                   | Description                                              |
| -------------- | -------------- | ----------------------------------------- | -------------------------------------------------------- |
| `version`      | String         | `'0.7.3'`                                 | PulledPork version to install.                           |
| `artifact_url` | String         | GitHub source archive for `version`       | Source archive URL.                                      |
| `dependencies` | Array          | Platform dependent                        | Packages required to run PulledPork.                     |
| `install_path` | String         | `'/usr/local/pulledpork-<version>'`       | Versioned install path.                                  |
| `prefix_root`  | String         | `'/usr/local'`                            | Root path for ark installation.                          |
| `prefix_bin`   | String         | `'/usr/local/bin'`                        | Directory where `pulledpork.pl` is linked.               |
| `backup`       | false, Integer | `5`                                       | Remote file backup count for the downloaded archive.     |

## Examples

```ruby
pulledpork_install 'default'
```

```ruby
pulledpork_install 'custom' do
  version '0.7.4'
  artifact_url 'https://example.test/pulledpork.tar.gz'
end
```
