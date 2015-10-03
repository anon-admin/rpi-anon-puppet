# Class: pdnsd
#
# This module manages pdnsd
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class pdnsd (
  $pdnsd_ip          = $pdnsd::params::pdnsd_ip,
  $pdnsd_port        = $pdnsd::params::pdnsd_port,
  $tor_ip            = $pdnsd::params::tor_ip,
  $tor_dns_port      = $pdnsd::params::tor_dns_port,
  $provider_domain   = $pdnsd::params::provider_domain,
  $prodiver_dns_ip   = $pdnsd::params::prodiver_dns_ip,
  $prodiver_dns_port = $pdnsd::params::prodiver_dns_port) inherits pdnsd::params {
    
  include userids

  $pdnsd_id = $userids::pdnsd_id
  $pdnsd_user = $userids::pdnsd_user
  
  $squid_id = $userids::squid_id
  $squid_user = $userids::squid_user

  contain pdnsd::install
  contain pdnsd::config
  contain pdnsd::service
}



