# frozen_string_literal: true

control 'pulledpork-install-01' do
  impact 1.0
  title 'PulledPork is installed'

  describe file('/opt/pulledpork-test/bin/pulledpork.pl') do
    it { should exist }
    it { should be_executable }
    it { should be_symlink }
    its('link_path') { should eq '/opt/pulledpork-test/pulledpork-0.7.3/pulledpork.pl' }
  end

  describe command('/opt/pulledpork-test/bin/pulledpork.pl -V') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/PulledPork.*0\.7\.3/i) }
  end
end

control 'pulledpork-config-01' do
  impact 1.0
  title 'PulledPork configuration is rendered'

  describe file('/etc/snort/pulledpork.conf') do
    it { should exist }
    its('mode') { should cmp '0640' }
    its('content') { should_not match(/^rule_url=/) }
    its('content') { should match %r{snort_path=/usr/sbin/snort} }
  end
end

control 'pulledpork-cron-01' do
  impact 0.7
  title 'PulledPork cron job is installed'

  describe crontab do
    its('commands') { should include "/opt/pulledpork-test/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l && service #{os.family == 'debian' ? 'snort' : 'snortd'} restart" }
  end
end
