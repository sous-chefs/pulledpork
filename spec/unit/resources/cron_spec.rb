# frozen_string_literal: true

require 'spec_helper'

describe 'pulledpork_cron' do
  step_into :pulledpork_cron
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      pulledpork_cron 'pulledpork'
    end

    it do
      is_expected.to create_cron('pulledpork').with(
        hour: '12',
        minute: '0',
        command: '/usr/local/bin/pulledpork.pl -c /etc/snort/pulledpork.conf -l && service snort restart'
      )
    end
  end

  context 'with custom properties' do
    recipe do
      pulledpork_cron 'pulledpork-custom' do
        config_path '/opt/snort/pulledpork.conf'
        snort_service_name 'snortd'
        hour 2
        minute 30
      end
    end

    it do
      is_expected.to create_cron('pulledpork-custom').with(
        hour: '2',
        minute: '30',
        command: '/usr/local/bin/pulledpork.pl -c /opt/snort/pulledpork.conf -l && service snortd restart'
      )
    end
  end

  context 'action :delete' do
    recipe do
      pulledpork_cron 'pulledpork' do
        action :delete
      end
    end

    it { is_expected.to delete_cron('pulledpork') }
  end
end
