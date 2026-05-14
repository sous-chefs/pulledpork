# frozen_string_literal: true

require 'spec_helper'

describe 'pulledpork_config' do
  step_into :pulledpork_config
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      pulledpork_config '/etc/snort/pulledpork.conf' do
        rule_urls ['https://snort.org/downloads/community/|community-rules.tar.gz|Community']
        disabled_sids [{ '129:4:1' => 'TCP timestamp outside PAWS window' }]
        run_on_update false
      end
    end

    it { is_expected.to create_directory('/etc/snort').with(recursive: true, mode: '0755') }
    it { is_expected.to create_directory('/etc/snort/rules').with(recursive: true, mode: '0755') }
    it { is_expected.to create_directory('/etc/snort/rules/iplists').with(recursive: true, mode: '0755') }
    it { is_expected.to create_directory('/var/log/snort').with(recursive: true, mode: '0755') }
    it { is_expected.to nothing_service('snort') }
    it { is_expected.to nothing_execute('run_pulledpork').with(command: '/usr/local/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l') }
    it { is_expected.to create_template('/etc/snort/disablesid.conf').with(mode: '0640') }
    it { is_expected.to create_template('/etc/snort/pulledpork.conf').with(mode: '0640') }
    it { is_expected.to create_directory('/usr/lib/snort_dynamicrules/').with(recursive: true, mode: '0755') }
    it { is_expected.to create_cookbook_file_if_missing('/usr/lib/snort_dynamicrules/os-linux.so').with(mode: '0655') }

    it do
      is_expected.to render_file('/etc/snort/pulledpork.conf')
        .with_content('rule_url=https://snort.org/downloads/community/|community-rules.tar.gz|Community')
    end

    it do
      is_expected.to render_file('/etc/snort/pulledpork.conf')
        .with_content('disablesid=/etc/snort/disablesid.conf')
    end

    it do
      is_expected.to render_file('/etc/snort/disablesid.conf')
        .with_content('129:4:1')
    end
  end

  context 'without disabled SIDs' do
    recipe do
      pulledpork_config '/etc/snort/pulledpork.conf'
    end

    it { is_expected.to_not create_template('/etc/snort/disablesid.conf') }
  end

  context 'action :delete' do
    recipe do
      pulledpork_config '/etc/snort/pulledpork.conf' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/snort/disablesid.conf') }
    it { is_expected.to delete_file('/etc/snort/pulledpork.conf') }
    it { is_expected.to delete_file('/usr/lib/snort_dynamicrules/os-linux.so') }
  end
end
