import "passwords"
import "consts"

class simple_puppet::params {
  include userids

  $puppetadmin_user = $userids::puppetadmin_user
  $puppetadmin_id = $userids::puppetadmin_id
  $puppetadmin_shell = '/bin/false'

  $reports_dir = "/var/lib/puppet/reports"
  $clientbucket_dir = "/var/lib/puppet/clientbucket"

  $box_identifier_array = split($hostname, "_")
  $manifest = $box_identifier_array[1]

}

class userids::params {
  include passwords

  $admin_pwd = $passwords::admin_pwd
  $admin_pwd_cr = $passwords::admin_pwd_cr
}

class source_interfaces inherits conf::network::config::interfaces {
  File["/etc/network/interfaces"] {
    source => "/etc/puppet/files/${hostname}/interfaces", }

}

class source_resolv inherits conf::network::config::resolv {
  File["/etc/resolv.conf"] {
    source => "/etc/puppet/files/${hostname}/resolv.conf", }

}

class i2p::params {
  $i2p_mountpoint = "/var/i2p"
  $i2p_home = "/var/lib/i2p"
  $i2p_version = "0.9.9"
  $i2p_service = "i2prouter"
  $i2p_confdir = "${i2p_home}/.i2p"
  $i2p_pidfile = "${i2p_confdir}/router.pid"
  $i2p_ip = "127.0.0.1"
  $i2p_webconsole_port = 7657
  $i2p_httpproxy_port = 4444
  $i2p_httpsproxy_port = 4445
}

class privoxy::params inherits consts {
  $tor_ip = $consts::tor_private_ip
  $tor_port = "9050"
  $privaten = $consts::privaten
}

class iptables::params (
  $domain_privaten      = $consts::domain_privaten,
  $localdomain          = $consts::localdomain,
  $provider_domain_name = $consts::provider_domain_name,
  $provider_domain      = $consts::provider_domain,
  $prodiver_dns_ip      = $consts::prodiver_dns_ip,
  $prodiver_dns_port    = $consts::prodiver_dns_port,
  $routeur_ip           = $consts::prodiver_dns_port,
  $routeur_private_ip   = $consts::prodiver_dns_port,
  $localn               = $consts::localn,
  $privaten             = $consts::privaten,
  $front_ip             = $consts::front_ip,
  $tor_ip               = $consts::tor_ip,
  $tor_private_ip       = $consts::tor_private_ip,
  $i2p_ip               = $consts::i2p_ip,
  $i2p_private_ip       = $consts::i2p_private_ip) inherits consts {
  $is_lxc_box = true
}

node default {
  mount { "/var/i2p": }

  include simple_puppet::client

  include conf
  include conf::network::config::no_dhcpcd

  class { 'conf::network': interfaces => ['eth0', 'eth1'], }

  include source_interfaces
  include source_resolv

  # no headless because of jdk oracle - include conf::headless
  include rsyslog

  include consts

  class { 'conf::apt_proxy': routeur => $consts::routeur_ip, }

  include iptables

  class { 'privoxy': template_name => "forward" }
  include i2p

}
