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
  $ntp_hwsync = undef,
  $ntp_hw_stratum = undef,
  $ntp_interface  = undef,
  $ntp_options    = undef,
  $ntp_servers) {
  contain ntp::install
  contain ntp::config
  contain ntp::service

}

