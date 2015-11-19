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
class iptables(
  $is_lxc_box = $iptables::params::is_lxc_box,
  $domain_privaten = $iptables::params::domain_privaten,
  $localdomain = $iptables::params::localdomain,
  $provider_domain_name = $iptables::params::provider_domain_name,
  $provider_domain = $iptables::params::provider_domain,
  $prodiver_dns_ip = $iptables::params::prodiver_dns_ip,
  $prodiver_dns_port = $iptables::params::prodiver_dns_port,
  $routeur_ip = $iptables::params::prodiver_dns_port,
  $routeur_private_ip = $iptables::params::prodiver_dns_port,
  $localn = $iptables::params::localn,
  $privaten = $iptables::params::privaten,
  $front_ip = $iptables::params::front_ip,
  $tor_ip = $iptables::params::tor_ip,
  $tor_private_ip = $iptables::params::tor_private_ip,
  $i2p_ip = $iptables::params::i2p_ip,
  $i2p_private_ip = $iptables::params::i2p_private_ip,
) inherits iptables::params {

  include conf::network::iptables
  include conf::network::install::iptables_latest
  
  contain iptables::config
  contain iptables::service
}
