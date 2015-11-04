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

class package_cron_up inherits conf::install::cron {
  Package["cron"] {
    ensure => latest, }

}

class service_cron_up inherits conf::service::cron {
  include package_cron_up

  Service["cron"] {
    ensure => running, }

}

class userids::params {
  include passwords

  $admin_pwd = $passwords::admin_pwd
  $admin_pwd_cr = $passwords::admin_pwd_cr
}

class tor::params {
  $tor_ip = $ipaddress_lo
  $tor_port = 9050
  $tor_external_public_port = 443
  $tor_external_port = 9090
  $tor_dns_port = 5353
  $tor_oignon_pages_port = 9040
}

class pdnsd::params {
  $pdnsd_ip = $ipaddress_eth0
  $pdnsd_port = 553
  
  include tor::params
  
  $tor_ip = $tor::params::tor_ip
  $tor_dns_port = $tor::params::tor_dns_port
  
  $provider_domain_name = "free"
  $provider_domain = ".ezvuu.com,.free.fr,.freebox.fr"
  $prodiver_dns_ip = "192.168.1.254"
  $prodiver_dns_port = 53
  $user_localdomain = ".ppprod.net,.ppprod.club"
}


class squid_base {
  include userids

  $squid_id = $userids::squid_id
  $squid_user = $userids::squid_user
  

#  exec { "/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}": require => Mount["/usr/local/bin"], }
#
#  group { "${squid_user}":
#    ensure => present,
#    gid    => "${squid_id}",
#  }
#  Exec["/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}"] -> Group["${squid_user}"]

  
}

class source_interfaces inherits conf::network::config::interfaces {

  File["/etc/network/interfaces"] {
    source => "/etc/puppet/files/${hostname}/interfaces", 
  }

}

node default {

  # Exec["/usr/bin/apt-get update"] -> Package<| |>

  include service_cron_up
  include simple_puppet::client

  include conf::network::config::no_dhcpcd
  include source_interfaces

  include squid_base

  include tor
  include pdnsd

}
