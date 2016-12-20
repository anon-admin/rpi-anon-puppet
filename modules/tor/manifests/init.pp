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
class tor($tor_ip,
  $tor_port,
  $tor_external_public_port,
  $tor_external_port,
  $tor_dns_port,
  $tor_oignon_pages_port) {
    
  include userids

  $tor_id = $userids::tor_id
  $tor_user = $userids::tor_user

  contain tor::install
  contain tor::config
  contain tor::service

}

