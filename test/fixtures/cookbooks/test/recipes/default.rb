apt_update 'update'

%w(/etc/snort /etc/snort/rules /etc/snort/rules/iplists /usr/lib/snort_dynamicrules /var/log/snort).each do |path|
  directory path do
    recursive true
  end
end

node.default['pulledpork']['snort_svc_name'] = 'pulledpork-test-snort'

systemd_unit 'pulledpork-test-snort.service' do
  content({
            Unit: {
              Description: 'PulledPork Kitchen restart target',
            },
            Service: {
              Type: 'oneshot',
              ExecStart: '/bin/true',
              RemainAfterExit: true,
            },
            Install: {
              WantedBy: 'multi-user.target',
            },
          })
  action [:create, :enable, :start]
  only_if { ::File.directory?('/run/systemd/system') }
end

%w(
  /etc/snort/snort.conf
  /etc/snort/classification.config
  /etc/snort/reference.config
  /etc/snort/threshold.conf
  /etc/snort/rules/community.rules
).each do |path|
  file path do
    content "# PulledPork Kitchen placeholder for #{::File.basename(path)}\n"
    mode '0644'
  end
end

file '/usr/sbin/snort' do
  content "#!/bin/sh\nexit 0\n"
  mode '0755'
end

include_recipe 'pulledpork'
