# == Class: splunkuf
#
# Installs and manages the Splunk Universal Forwarder
#
# === Parameters
#
# [*clientname*]
#   String accepts a client
#   e.g. "$hostname-$role"
#
# [*targeturi*]
#   String accepts a deployment server and port
#   e.g. "deploymentserver.tld:8089"
#
# [*system_user*]
#   System user that run splunk binary
#   e.g. "splunk"
#
# [*phonehomeintervalinsecs*]
#   Integer accepts number
#   e.g. 60
#
# === Examples
#
#  class { 'splunkuf':
#    targeturi => 'deploymentserver.tld:8089',
#  }
#
# === Authors
#
# Paul Badcock <paul@bad.co.ck>
#
# === Copyright
#
# Copyright 2015 Paul Badcock, unless otherwise noted.
#
class splunkuf (
  $clientname              = $::splunkuf::params::clientname,
  $mgmthostport            = $::splunkuf::params::mgmthostport,
  $phonehomeintervalinsecs = $::splunkuf::params::phonehomeintervalinsecs,
  $system_user             = $::splunkuf::params::system_user,
  $systemd                 = $::splunkuf::params::systemd,
  $targeturi               = $::splunkuf::params::targeturi,
) inherits splunkuf::params {

  package { 'splunkforwarder':
    ensure => latest,
  }

  case $systemd {
    true: {
      file { '/etc/systemd/system/splunkforwarder.service':
        owner   => 'root',
        group   => 'root',
        mode    => '0664',
        content => template('splunkuf/splunkforwarder.service.erb'),
      }
    }
    default: {
      file { '/etc/init.d/splunkforwarder':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template('splunkuf/splunkforwarder.erb'),
      }
    }
  }

  file { '/opt/splunkforwarder':
    ensure  => directory,
    owner   => $system_user,
    group   => $system_user,
    recurse => true,
    require => Package['splunkforwarder'],
  }
  -> file { '/opt/splunkforwarder/etc/system/local/deploymentclient.conf':
    owner   => $system_user,
    group   => $system_user,
    mode    => '0644',
    content => template('splunkuf/deploymentclient.conf.erb'),
    notify  => Service['splunkforwarder'],
  }

  if $mgmthostport != undef {
    file { '/opt/splunkforwarder/etc/system/local/web.conf':
      owner   => $system_user,
      group   => $system_user,
      mode    => '0644',
      content => template('splunkuf/web.conf.erb'),
      notify  => Service['splunkforwarder'],
      require => Package['splunkforwarder'],
    }
  }

  service { 'splunkforwarder':
    ensure => 'running',
    enable => true,
  }
}
