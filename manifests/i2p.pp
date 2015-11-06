import "passwords"

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
    source => "/etc/puppet/files/${hostname}/interfaces", 
  }

}

class source_resolv inherits conf::network::config::resolv {

  File["/etc/resolv.conf"] {
    source => "/etc/puppet/files/${hostname}/resolv.conf", 
  }

}

class i2p::params {
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

node default {

  include simple_puppet::client

  include conf
  include conf::network::config::no_dhcpcd
  
  include source_interfaces
  include source_resolv
  
  # no headless because of jdk oracle - include conf::headless
  include rsyslog
  
  class { 'conf::apt_proxy': routeur => "192.168.1.2", }
  
  include i2p

}
