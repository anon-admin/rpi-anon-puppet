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

node default {

  include simple_puppet::client

  include conf
  include conf::network::config::no_dhcpcd
  
  class { 'conf::network':
    interfaces => ['eth0','eth1'],
  }
  
  include source_interfaces
  include source_resolv
  
  include rsyslog
  
  class { 'conf::apt_proxy': routeur => "192.168.1.2", }

}
