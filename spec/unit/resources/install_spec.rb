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
        %w(perl-libwww-perl perl-Crypt-SSLeay perl-Archive-Tar perl-Sys-Syslog perl-LWP-Protocol-https perl-File-Copy)
      )
    end
  end

  context 'with custom install and bin paths' do
    recipe do
      pulledpork_install 'custom' do
        prefix_root '/opt/pulledpork'
        install_path '/opt/pulledpork/releases/current'
        prefix_bin '/opt/tools/bin'
      end
    end

    it do
      is_expected.to install_ark('pulledpork').with(
        path: '/opt/pulledpork/releases/current',
        prefix_home: '/opt/pulledpork',
        prefix_bin: '/opt/tools/bin'
      )
    end

    it { is_expected.to create_file('/opt/pulledpork/releases/current/pulledpork.pl').with(mode: '0755') }
  end

  context 'action :remove' do
    recipe do
      pulledpork_install 'default' do
        action :remove
      end
    end

    before do
      allow(File).to receive(:readlink).and_call_original
      allow(File).to receive(:readlink).with('/usr/local/pulledpork').and_return('/usr/local/pulledpork-0.7.3')
      allow(File).to receive(:readlink).with('/usr/local/bin/pulledpork.pl').and_return('/usr/local/pulledpork-0.7.3/pulledpork.pl')
    end

    it { is_expected.to delete_link('/usr/local/pulledpork') }
    it { is_expected.to delete_link('/usr/local/bin/pulledpork.pl') }
    it { is_expected.to delete_directory('/usr/local/pulledpork-0.7.3').with(recursive: true) }

    context 'with custom prefixes' do
      recipe do
        pulledpork_install 'custom' do
          prefix_root '/opt/pulledpork'
          prefix_bin '/opt/tools/bin'
          action :remove
        end
      end

      before do
        allow(File).to receive(:readlink).with('/opt/pulledpork/pulledpork').and_return('/opt/pulledpork/pulledpork-0.7.4')
        allow(File).to receive(:readlink).with('/opt/tools/bin/pulledpork.pl').and_return('/opt/pulledpork/pulledpork-0.7.4/pulledpork.pl')
      end

      it { is_expected.not_to delete_link('/opt/pulledpork/pulledpork') }
      it { is_expected.not_to delete_link('/opt/tools/bin/pulledpork.pl') }
      it { is_expected.to delete_directory('/opt/pulledpork/pulledpork-0.7.3').with(recursive: true) }
    end
  end
end
