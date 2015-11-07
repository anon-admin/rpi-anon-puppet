# Class: i2p
#
# This module manages i2p
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class i2p ($i2p_ip = $i2p::params::i2p_ip, $i2p_home = $i2p::params::i2p_home, $i2p_mountpoint = $i2p::params::i2p_mountpoint) 
inherits i2p::params {
  include userids

  $i2p_id = $userids::i2p_id
  $i2p_user = $userids::i2p_user

  contain i2p::install
  contain i2p::config

  file { ["/etc/i2p", "/var/log/i2p", "${i2p_home}", "/usr/share/i2p"]: }

  package { ["i2p", "i2p-keyring"]: }

  file { [
    "/etc/i2p/wrapper.config",
    "${i2p_home}/i2p-config/clients.config",
    "${i2p_home}/i2p-config/i2ptunnel.config"]:
  }

}
