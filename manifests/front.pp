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

class dnsmasq::params {
  $dnsmasq_if_privaten = "eth0"
  $dnsmasq_domain_privaten = "ppprod.prv"
  $dnsmasq_privaten = "10.1.0"
  $dnsmasq_routeur = $ipaddress_eth0
  $dnsmasq_ntpserv = $ipaddress_eth0
}

class polipo::params {
  $tor_ip                = "192.168.1.3"
  $tor_port              = "9050"
}

class privoxy::params {
  $privoxy_ip            = $ipaddress_eth0
  $privoxy_port          = 8118
  $tor_ip                = "192.168.1.3"
  $tor_port              = "9050"
  $tor_oignon_pages_port = "9040"
  $polipo_ip             = "127.0.0.1"
  $polipo_port           = 8123
  $i2p_ip                = "10.1.0.3"
  $i2p_httpproxy_port    = 4444
  $i2p_httpsproxy_port   = 4445
  $i2p_webconsole_port   = 7657
  $localn                = "192.168.1"
  $privaten              = "10.1.0"  
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
  
  include consts
  class { 'conf::apt_proxy': routeur => $ipaddress_eth0, }
  class { 'simple_apt_cacher::service': 
    proxy_ip => $consts::routeur_private_ip, 
    proxy_port => 9999
  }
  Class['simple_apt_cacher::service'] -> Class['conf::apt_proxy']

  include dnsmasq
  include ntp
  include privoxy
  include polipo
  #incluse sshd

}
