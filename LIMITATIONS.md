# Limitations

## Package Availability

PulledPork is distributed as source from the upstream GitHub repository rather than through
official APT, DNF, or YUM repositories. This cookbook downloads the selected source archive
and installs runtime Perl dependencies from the operating system package repositories.

### APT (Debian/Ubuntu)

* Debian 12 and 13: installs `libcrypt-ssleay-perl` and `liblwp-useragent-determined-perl`.
* Ubuntu 22.04 and 24.04: installs `libcrypt-ssleay-perl` and `liblwp-useragent-determined-perl`.

### DNF/YUM (RHEL family)

* Amazon Linux 2023, Enterprise Linux 8 and 9 derivatives, and Fedora: installs
  `perl-libwww-perl`, `perl-Crypt-SSLeay`, `perl-Archive-Tar`, `perl-Sys-Syslog`,
  and `perl-LWP-Protocol-https`.
* CentOS Linux 7 and CentOS Stream 8 are not included because they are end of life.

### Zypper (SUSE)

* No SUSE support is declared by this cookbook. The legacy cookbook had no SUSE dependency
  mapping.

## Architecture Limitations

PulledPork itself is a Perl script and is not architecture-specific. Platform package
availability for Perl dependencies is controlled by the operating system repositories.

## Source Installation

PulledPork source archives are downloaded from `https://github.com/shirkdog/pulledpork`.
The upstream repository is not archived, but its last observed push was in July 2021.

## Known Issues

* This cookbook assumes Snort is installed and configured separately.
* Running PulledPork requires at least one configured rule URL.
* Snort rule downloads may require network access and, for non-community rules, an oinkcode.
