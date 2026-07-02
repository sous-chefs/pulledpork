# AGENTS.md

## Policyfile Migration Notes

This cookbook uses `Policyfile.rb` for dependency resolution. Keep the Kitchen
default suite on `recipe[test::default]` so the named run list generated from
the test cookbook continues to match CI.

## Platform Support

Legacy platforms such as CentOS 6/7, Debian 8/9, and Ubuntu 16.04 are no longer
tested. Current Dokken coverage is limited to maintained Debian, Ubuntu,
Amazon Linux, and Enterprise Linux compatible releases declared in
`metadata.rb`, `kitchen.yml`, `kitchen.global.yml`, `kitchen.dokken.yml`, and
`.github/workflows/ci.yml`.

## Integration Tests

The default Kitchen suite leaves `node['pulledpork']['rule_url_array']` empty.
This intentionally validates convergence without depending on rate-limited
external Snort community rule downloads. Set `rule_url_array` explicitly when
testing a real PulledPork rule update.
