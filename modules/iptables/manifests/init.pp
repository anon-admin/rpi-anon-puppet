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
  $is_lxc_box,
  $domain_privaten,
  $localdomain,
  $provider_domain_name,
  $provider_domain,
  $prodiver_dns_ip,
  $prodiver_dns_port,
  $routeur_ip,
  $routeur_private_ip,
  $localn,
  $privaten,
  $front_ip,
  $tor_ip,
  $tor_private_ip,
  $i2p_ip,
  $i2p_private_ip
) {

  include conf::network::iptables
  include conf::network::install::iptables_latest
  
  contain iptables::config
  contain iptables::service
}
