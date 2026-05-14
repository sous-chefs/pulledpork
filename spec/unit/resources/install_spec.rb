# frozen_string_literal: true

require 'spec_helper'

describe 'pulledpork_install' do
  step_into :pulledpork_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      pulledpork_install 'default'
    end

    it { is_expected.to install_package(%w(libcrypt-ssleay-perl liblwp-useragent-determined-perl)) }

    it do
      is_expected.to install_ark('pulledpork').with(
        url: 'https://github.com/shirkdog/pulledpork/archive/0.7.3.tar.gz',
        version: '0.7.3',
        prefix_root: '/usr/local',
        prefix_bin: '/usr/local/bin',
        has_binaries: %w(pulledpork.pl)
      )
    end

    it { is_expected.to create_file('/usr/local/pulledpork-0.7.3/pulledpork.pl').with(mode: '0755') }
  end

  context 'on RHEL family' do
    platform 'almalinux', '9'

    recipe do
      pulledpork_install 'default'
    end

    it do
      is_expected.to install_package(
        %w(perl-libwww-perl perl-Crypt-SSLeay perl-Archive-Tar perl-Sys-Syslog perl-LWP-Protocol-https)
      )
    end
  end

  context 'action :remove' do
    recipe do
      pulledpork_install 'default' do
        action :remove
      end
    end

    it { is_expected.to delete_link('/usr/local/pulledpork') }
    it { is_expected.to delete_link('/usr/local/bin/pulledpork.pl') }
    it { is_expected.to delete_directory('/usr/local/pulledpork-0.7.3').with(recursive: true) }
  end
end
