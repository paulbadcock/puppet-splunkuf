# == Class: splunkuf
#
# Installs and manages the Splunk Universal Forwarder
#
# === Parameters
#
# [*targeturi*]
#   String accepts a deployment server and port
#   e.g. "deploymentserver.tld:8089"
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
  $targeturi  = $::splunkuf::params::targeturi,
  $systemd = $::splunkuf::params::systemd,
) inherits splunkuf::params {

  package {'splunkforwarder':
    ensure => latest,
  }

  case $systemd {
    true: {
      file {'/usr/lib/systemd/system/splunkforwarder.service':
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///modules/splunkuf/splunkforwarder.service',
      }
    }
    default: {
      file {'/etc/init.d/splunkforwarder':
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
        source => 'puppet:///modules/splunkuf/splunkforwarder',
      }
    }
  }

  file {'/opt/splunkforwarder/targeturi':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "Deployment Server is: ${targeturi}",
    require => Package['splunkforwarder'],
  }

  service {'splunkforwarder':
    ensure => 'running',
    enable => true,
  }

  exec {'Set deployment server':
    command     => "/opt/splunkforwarder/bin/splunk set deploy-poll ${targeturi} -auth admin:changeme",
    path        => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    subscribe   => File['/opt/splunkforwarder/targeturi'],
    notify      => Service['splunkforwarder'],
    refreshonly => true,
  }
}
