# Class: ntp
#
# This module manages ntp
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class ntp (
  $ntp_hwsync     = $ntp::params::ntp_hwsync,
  $ntp_hw_stratum = $ntp::params::ntp_hw_stratum,
  $ntp_servers    = $ntp::params::ntp_servers) inherits ntp::params {
    
  contain ntp::install

  class { 'ntp::config':
    ntp_hwsync     => $ntp_hwsync,
    ntp_hw_stratum => $ntp_hw_stratum,
    ntp_servers    => $ntp_servers
  }

  contain ntp::service

}

