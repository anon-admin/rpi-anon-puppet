# Class: dnsmasq
#
# This module manages dnsmasq
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class dnsmasq (
  $dnsmasq_if_privaten     = $dnsmasq::params::dnsmasq_if_privaten,
  $dnsmasq_domain_privaten = $dnsmasq::params::dnsmasq_domain_privaten,
  $dnsmasq_privaten        = $dnsmasq::params::dnsmasq_privaten,
  $dnsmasq_routeur         = $dnsmasq::params::dnsmasq_routeur,
  $dnsmasq_ntpserv         = $dnsmasq::params::dnsmasq_ntpserv) inherits dnsmasq::params {
  include userids

  $dnsmasq_id = $userids::dnsmasq_id
  $dnsmasq_user = $userids::dnsmasq_user

  contain dnsmasq::install
  contain dnsmasq::config
  contain dnsmasq::service

}
