# frozen_string_literal: true

control 'pulledpork-install-01' do
  impact 1.0
  title 'PulledPork is installed'

  describe file('/usr/local/bin/pulledpork.pl') do
    it { should exist }
    it { should be_executable }
  end
end

control 'pulledpork-config-01' do
  impact 1.0
  title 'PulledPork configuration is rendered'

  describe file('/etc/snort/pulledpork.conf') do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('content') { should match %r{rule_url=https://snort.org/downloads/community/\|community-rules.tar.gz\|Community} }
    its('content') { should match %r{snort_path=/usr/sbin/snort} }
  end
end

control 'pulledpork-cron-01' do
  impact 0.7
  title 'PulledPork cron job is installed'

  describe crontab do
    its('commands') { should include '/usr/local/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l && service snort restart' }
  end
end
