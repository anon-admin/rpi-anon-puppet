# Class: tor
#
# This module manages tor
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class tor () {
  include userids

  $tor_id = $userids::tor_id
  $tor_user = $userids::tor_user

  contain tor::install
  contain tor::config
  contain tor::service

}

