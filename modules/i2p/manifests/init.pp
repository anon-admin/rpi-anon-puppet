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
class i2p($i2p_ip = $i2p::params::i2p_ip) inherits i2p::params {

  include userids

  $i2p_id = $userids::i2p_id
  $i2p_user = $userids::i2p_user

  contain i2p::install

}
