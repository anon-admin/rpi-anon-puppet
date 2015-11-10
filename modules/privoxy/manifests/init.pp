# Class: privoxy
#
# This module manages privoxy
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class privoxy (
  $privoxy_ip            = $privoxy::params::privoxy_ip,
  $privoxy_port          = $privoxy::params::privoxy_port,
  $tor_ip                = $privoxy::params::tor_ip,
  $tor_port              = $privoxy::params::tor_port,
  $tor_oignon_pages_port = $privoxy::params::tor_oignon_pages_port,
  $polipo_ip             = $privoxy::params::polipo_ip,
  $polipo_port           = $privoxy::params::polipo_port,
  $i2p_ip                = $privoxy::params::i2p_ip,
  $i2p_httpproxy_port    = $privoxy::params::i2p_httpproxy_port,
  $i2p_webconsole_port   = $privoxy::params::i2p_webconsole_port,
  $localn                = $privoxy::params::localn,
  $privaten              = $privoxy::params::privaten) inherits privoxy::params {
  include userids

  $privoxy_id = $userids::privoxy_id
  $privoxy_user = $userids::privoxy_user

  contain privoxy::install
  contain privoxy::config
  contain privoxy::service
}
