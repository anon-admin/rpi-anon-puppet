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

class iptables::params(
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
  $i2p_private_ip       = $consts::i2p_private_ip
) inherits consts {
  $is_lxc_box = true
}

class tor::params inherits consts {
  $tor_ip = $ipaddress_lo
  $tor_port = 9050
  $tor_external_public_port = 443
  $tor_external_port = 9090
  $tor_dns_port = 5353
  $tor_oignon_pages_port = 9040
}

class pdnsd::params(
  $user_localdomain = $consts::localdomain,
  $provider_domain_name = $consts::provider_domain_name,
  $provider_domain = $consts::provider_domain,
  $prodiver_dns_ip = $consts::prodiver_dns_ip,
  $prodiver_dns_port = $consts::prodiver_dns_port  
) inherits consts {
  include passwords

  $pdnsd_ip = "0.0.0.0"
  $pdnsd_port = 53
  
  include tor::params
  
  $tor_ip = $tor::params::tor_ip
  $tor_dns_port = $tor::params::tor_dns_port
  
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

  # Exec["/usr/bin/apt-get update"] -> Package<| |>

  #include service_cron_up
  include simple_puppet::client

  include conf
  include conf::network::config::no_dhcpcd

  class { 'conf::network':
    interfaces => ['eth0','eth1'],
  }
  
  
  #include source_interfaces
  #include source_resolv

  include rsyslog
  include monit

  #include consts
  #class { 'conf::apt_proxy': routeur => $consts::routeur_ip, }
  
  #include iptables
  
  #include tor
  include pdnsd

}
