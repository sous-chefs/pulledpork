require 'spec_helper'

describe 'default recipe on Ubuntu 24.04' do
  let(:runner) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '24.04') }
  let(:chef_run) { runner.converge('pulledpork::default') }

  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end
end

describe 'default attributes on RHEL-family platforms' do
  {
    'almalinux' => '8',
    'oracle' => '8',
    'rocky' => '8',
  }.each do |platform, version|
    context "#{platform} #{version}" do
      let(:chef_run) { ChefSpec::ServerRunner.new(platform: platform, version: version).converge('pulledpork::default') }

      it 'does not install perl-File-Copy' do
        expect(chef_run.node['pulledpork']['dependencies']).not_to include('perl-File-Copy')
      end
    end
  end

  context 'rocky 9' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'rocky', version: '9').converge('pulledpork::default') }

    it 'installs perl-File-Copy' do
      expect(chef_run.node['pulledpork']['dependencies']).to include('perl-File-Copy')
    end
  end
end
