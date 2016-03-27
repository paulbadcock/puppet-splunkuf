# == Class: params
#
# Default settings for Splunk Universal Forwarder
#
# === Variables
#
# [*targeturi*]
#   String accepts a deployment server and port.
#   e.g. "deploymentserver.tld:8089"
#
# === Authors
#
# Paul Badcock <paul@bad.co.ck>
#
# === Copyright
#
# Copyright 2015 Paul Badcock, unless otherwise noted.
#
class splunkuf::params {
  $targeturi = 'spunk.tld:8089'

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      case $::operatingsystemmajrelease {
        '7': {
          $systemd = true
        }
        default: {
          $systemd = false
        }
      }
    }
    /^(Debian|Ubuntu)$/: {
      $systemd = false
    }
    default: {
      $systemd = false
    }
  }
}
