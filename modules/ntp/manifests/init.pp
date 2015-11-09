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
  $ntp_interface  = $ntp::params::ntp_interface,
  $ntp_options    = $ntp::params::ntp_options,
  $ntp_servers    = $ntp::params::ntp_servers) inherits ntp::params {
  contain ntp::install
  contain ntp::config
  contain ntp::service

}

