# Class: infradef
#
# This module manages infradef
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class infradef($routeur,
  $localn,
  $domain_family,
  $local_domain_extension,
  $local_domains,
  $provider_domain_name,
  $provider_domain,
  $prodiver_dns_ip_lastdigit,
  $prodiver_dns_ip_full = unset,
  $prodiver_dns_port) {

  $local_domain = "${domain_family}.${local_domain_extension}"
  if ($prodiver_dns_ip_full != unset) {
    $prodiver_dns_ip = "${prodiver_dns_ip_full}"
  } else {
    $prodiver_dns_ip = "${localn}.${prodiver_dns_ip_lastdigit}"
  }
}
