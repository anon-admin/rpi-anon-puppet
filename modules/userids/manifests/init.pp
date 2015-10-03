# Class: userids
#
# This module manages userids
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class userids ($admin_pwd = $userids::params::admin_pwd, $admin_pwd_cr = $userids::params::admin_pwd_cr) inherits userids::params {

  $puppetadmin_id = 495
  $puppetadmin_user = "puppetadmin"
  $puppetadmin_pwd = "$admin_pwd"
  $puppetadmin_pwd_cr = "$admin_pwd_cr"

  $anonymous_id = 1000
  $anonymous_user = "anonymous"

  $squid_id = 13
  $squid_user = "proxy"

  $pdnsd_id = 108
  $pdnsd_user = pdnsd

  $privoxy_id = 109
  $privoxy_user = privoxy

  $dnsmasq_id = 110
  $dnsmasq_user = "dnsmasq"

  $dnsproxy_id = 111
  $dnsproxy_user = dnsproxy

  $acng_id = 112
  $acng_user = "apt-cacher-ng"

  $bind_id = 113
  $bind_user = "bind"

  $mysql_id = 115
  $mysql_user = mysql

  # $bind_id = 116
  # $bind_user = bind

  $tor_id = 117
  $tor_user = "debian-tor"

  $watchdog_id = 118
  $watchdog_user = watchdog

  $pritorxy_id = 119
  $pritorxy_user = pritorxy

  $i2p_id = 122
  $i2p_user = "i2p"

}

