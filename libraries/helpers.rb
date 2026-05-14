# frozen_string_literal: true

module Pulledpork
  module Cookbook
    module Helpers
      def default_pulledpork_dependencies
        case node['platform_family']
        when 'debian'
          %w(libcrypt-ssleay-perl liblwp-useragent-determined-perl)
        when 'rhel', 'fedora', 'amazon'
          %w(perl-libwww-perl perl-Crypt-SSLeay perl-Archive-Tar perl-Sys-Syslog perl-LWP-Protocol-https)
        end
      end

      def default_snort_service_name
        case node['platform_family']
        when 'debian'
          'snort'
        when 'rhel', 'fedora', 'amazon'
          'snortd'
        else
          'snort'
        end
      end
    end
  end
end
