# Class: iptables
#
# This module manages iptables
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class iptables($is_lxc_box = $iptables::params::is_lxc_box) inherits iptables::params {
  include conf::network::iptables
  include conf::network::install::iptables_latest
  
  contain iptables::config
  contain iptables::service
}
