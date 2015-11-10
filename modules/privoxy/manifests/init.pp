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
class privoxy inherits privoxy::params {
    
  include userids

  $privoxy_id = $userids::privoxy_id
  $privoxy_user = $userids::privoxy_user

  contain privoxy::install
  contain privoxy::config
  contain privoxy::service
}
