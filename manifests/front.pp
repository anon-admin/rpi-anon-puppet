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
    source => "/etc/puppet/files/${hostname}/interfaces", 
  }

}

class source_resolv inherits conf::network::config::resolv {

  File["/etc/resolv.conf"] {
    source => "/etc/puppet/files/${hostname}/resolv.conf", 
  }

}

class ntp::params {
  $ntp_hwsync=yes
  $ntp_hw_stratum=8
  $ntp_interface="eth0"
  $ntp_options="-4"
  $ntp_servers=[]
}

class dnsmasq::params inherits consts {
  $dnsmasq_if_privaten = "eth0"
  $dnsmasq_domain_privaten = $consts::domain_privaten
  $dnsmasq_privaten = $consts::privaten
  $dnsmasq_routeur = $ipaddress_eth0
  $dnsmasq_ntpserv = $ipaddress_eth0
}

class privoxy::params inherits consts {
  $privoxy_ip            = $ipaddress_eth0
  $privoxy_port          = 8118
  $tor_ip                = $consts::tor_private_ip
  $tor_port              = "9050"
  $tor_oignon_pages_port = "9040"
  $polipo_ip             = "127.0.0.1"
  $polipo_port           = 8123
  $i2p_ip                = $consts::i2p_private_ip
  $i2p_httpproxy_port    = 4444
  $i2p_httpsproxy_port   = 4445
  $i2p_webconsole_port   = 7657
  $localn                = $consts::localn
  $privaten              = $consts::privaten  
}

class polipo::params(
  $tor_ip                = $privoxy::params::tor_ip,
  $tor_port              = $privoxy::params::tor_port
) inherits privoxy::params {
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

node default {

  include simple_puppet::client

  include conf
  include conf::network::config::no_dhcpcd
  
  class { 'conf::network':
    interfaces => ['eth0'],
  }
  
  include source_interfaces
  include source_resolv
  
  include rsyslog
  include monit
  
  include consts
  class { 'conf::apt_proxy': routeur => $ipaddress_eth0, }
  class { 'simple_apt_cacher::service': 
    proxy_ip => $consts::routeur_private_ip, 
    proxy_port => 9999
  }
  Class['simple_apt_cacher::service'] -> Class['conf::apt_proxy']

  class { 'conf::http_proxy':
    http_proxy_ip    => "localhost",
    http_proxy_port  => 8118,
    https_proxy_ip   => "localhost",
    https_proxy_port => 8118
  }
  include dnsmasq
  include ntp
  include privoxy
  include polipo
  incluse sshd

  include iptables
}
