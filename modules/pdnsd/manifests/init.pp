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
  $pdnsd_ip,
  $pdnsd_port,
  $tor_ip,
  $tor_dns_port,
  $provider_domain_name,
  $provider_domain,
  $prodiver_dns_ip,
  $prodiver_dns_port,
  $user_localdomain_name,
  $user_dns_ip,
  $user_localdomain,
  $pdnsd_cachedir = $pdnsd::params::pdnsd_cachedir) inherits pdnsd::params {
    
  include userids

  $pdnsd_id = $userids::pdnsd_id
  $pdnsd_user = $userids::pdnsd_user
  
  $squid_id = $userids::squid_id
  $squid_user = $userids::squid_user

  contain pdnsd::install
  contain pdnsd::config
  contain pdnsd::service
}



