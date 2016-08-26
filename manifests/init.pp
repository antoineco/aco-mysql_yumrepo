# == Class: mysql_yumrepo
#
# This module installs the MySQL Community YUM repository on RHEL-variants
#
# === Parameters:
#
# [*gpgcheck*]
#   enable or disable GPG signature check (valid: '0'|'1')
# [*enable_connectors*]
#   enable or disable connectors repository (valid: '0'|'1')
# [*enable_tools*]
#   enable or disable tools repository (valid: '0'|'1')
# [*enable_tools_preview*]
#   enable or disable tools preview repository (valid: '0'|'1')
# [*enable_55*]
#   enable or disable mysql55 repository (valid: '0'|'1')
# [*enable_56*]
#   enable or disable mysql56 repository (valid: '0'|'1')
# [*enable_57*]
#   enable or disable mysql56 repository (valid: '0'|'1')
# [*enable_connectors_src*]
#   enable or disable connectors source repository (valid: '0'|'1')
# [*enable_tools_src*]
#   enable or disable tools source repository (valid: '0'|'1')
# [*enable_tools__preview_src*]
#   enable or disable tools preview source repository (valid: '0'|'1')
# [*enable_55_src*]
#   enable or disable mysql55 source repository (valid: '0'|'1')
# [*enable_56_src*]
#   enable or disable mysql56 source repository (valid: '0'|'1')
# [*enable_57_src*]
#   enable or disable mysql56 source repository (valid: '0'|'1')
#
# === Actions:
#
# * Install MySQL Community YUM repositories
#
# === Requires:
#
# (none)
#
# === Sample Usage:
#
#  class { '::mysql_yumrepo':
#    gpgcheck  => '0',
#    enable_57 => '1'
#  }
#
class mysql_yumrepo (
  $gpgcheck                 = 1,
  $enable_connectors        = 1,
  $enable_tools             = 1,
  $enable_tools_preview     = 0,
  $enable_55                = 0,
  $enable_56                = 0,
  $enable_57                = 1,
  $enable_connectors_src    = 0,
  $enable_tools_src         = 0,
  $enable_tools_preview_src = 0,
  $enable_55_src            = 0,
  $enable_56_src            = 0,
  $enable_57_src            = 0) {
  case $::osfamily {
    'RedHat', 'Suse': {
      $os = $::operatingsystem ? {
        /^(SLES|SLED|SuSE)$/ => 'sles',
        'Fedora'             => 'fc',
        default              => 'el'
      }

      # install YUM repositories
      Yumrepo {
        gpgcheck => $gpgcheck,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-mysql'
      }

      yumrepo { 'mysql-connectors-community':
        descr   => 'MySQL Connectors Community',
        baseurl => "http://repo.mysql.com/yum/mysql-connectors-community/${os}/${::operatingsystemmajrelease}/\$basearch/",
        enabled => $enable_connectors
      }

      yumrepo { 'mysql-connectors-community-source':
        descr   => 'MySQL Connectors Community - Source',
        baseurl => "http://repo.mysql.com/yum/mysql-connectors-community/${os}/${::operatingsystemmajrelease}/SRPMS",
        enabled => $enable_connectors_src
      }

      unless ($os == 'el' and versioncmp($::operatingsystemmajrelease, '5') == 0) {
        yumrepo { 'mysql-tools-community':
          descr   => 'MySQL Tools Community',
          baseurl => "http://repo.mysql.com/yum/mysql-tools-community/${os}/${::operatingsystemmajrelease}/\$basearch/",
          enabled => $enable_tools
        }

        yumrepo { 'mysql-tools-community-source':
          descr   => 'MySQL Tools Community - Source',
          baseurl => "http://repo.mysql.com/yum/mysql-tools-community/${os}/${::operatingsystemmajrelease}/SRPMS",
          enabled => $enable_tools_src
        }
      }

      if ($os == 'el' and versioncmp($::operatingsystemmajrelease, '6') >= 0) or ($os == 'fc' and versioncmp($::operatingsystemmajrelease, '22') >= 0) {
        yumrepo { 'mysql-tools-preview':
          descr   => 'MySQL Tools Preview',
          baseurl => "http://repo.mysql.com/yum/mysql-tools-preview/${os}/${::operatingsystemmajrelease}/\$basearch/",
          enabled => $enable_tools_preview
        }

        yumrepo { 'mysql-tools-preview-source':
          descr   => 'MySQL Tools Preview - Source',
          baseurl => "http://repo.mysql.com/yum/mysql-tools-preview/${os}/${::operatingsystemmajrelease}/SRPMS",
          enabled => $enable_tools_preview_src
        }
      }

      if ($os == 'el' and versioncmp($::operatingsystemmajrelease, '6') >= 0) or ($os == 'sles' and versioncmp($::operatingsystemmajrelease, '11') == 0) {
        yumrepo { 'mysql55-community':
          descr   => 'MySQL 5.5 Community Server',
          baseurl => "http://repo.mysql.com/yum/mysql-5.5-community/${os}/${::operatingsystemmajrelease}/\$basearch/",
          enabled => $enable_55
        }

        yumrepo { 'mysql55-community-source':
          descr   => 'MySQL 5.5 Community Server - Source',
          baseurl => "http://repo.mysql.com/yum/mysql-5.5-community/${os}/${::operatingsystemmajrelease}/SRPMS",
          enabled => $enable_55_src
        }
      }

      yumrepo { 'mysql56-community':
        descr   => 'MySQL 5.6 Community Server',
        baseurl => "http://repo.mysql.com/yum/mysql-5.6-community/${os}/${::operatingsystemmajrelease}/\$basearch/",
        enabled => $enable_56
      }

      yumrepo { 'mysql56-community-source':
        descr   => 'MySQL 5.6 Community Server - Source',
        baseurl => "http://repo.mysql.com/yum/mysql-5.6-community/${os}/${::operatingsystemmajrelease}/SRPMS",
        enabled => $enable_56_src
      }

      yumrepo { 'mysql57-community':
        descr   => 'MySQL 5.7 Community Server',
        baseurl => "http://repo.mysql.com/yum/mysql-5.7-community/${os}/${::operatingsystemmajrelease}/\$basearch/",
        enabled => $enable_57
      }

      yumrepo { 'mysql57-community-source':
        descr   => 'MySQL 5.7 Community Server - Source',
        baseurl => "http://repo.mysql.com/yum/mysql-5.7-community/${os}/${::operatingsystemmajrelease}/SRPMS",
        enabled => $enable_57_src
      }

      # install GPG key
      file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/${module_name}/RPM-GPG-KEY-mysql",
      }

      mysql_yumrepo::rpm_gpg_key { 'MySQL Community GPG key': path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' }
    }
    default         : {
      fail("Unsupported operating system family ${::osfamily}")
    }
  }
}
