# == Class: params
#
# Default settings for Splunk Universal Forwarder
#
# === Variables
#
# [*clientname*]
#   String accepts a client
#   e.g. "$hostname-$role"
#
# [*targeturi*]
#   String accepts a deployment server and port.
#   e.g. "deploymentserver.tld:8089"
#
# [*system_user*]
#   System user that run splunk binary
#   e.g. "splunk"
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
  $targeturi   = 'spunk.tld:8089'
  $system_user = 'splunk'

  $mgmthostport = undef

  $clientname  = undef

  case $::osfamily {
    'RedHat': {
      if versioncmp($::operatingsystemmajrelease, '7') >= 0 {
        $systemd = true
      }
    }
    'Debian': {
      if versioncmp($::operatingsystemmajrelease, '8') >= 0 {
        $systemd = true
      }
    }
    'Ubuntu': {
      if versioncmp($::operatingsystemmajrelease, '15') >= 0 {
        $systemd = true
      }
    }
    default: {
      $systemd = false
    }
  }
}
