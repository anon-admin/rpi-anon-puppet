
class params {
  $box_identifier_array = split($hostname, "_")
  $manifest = $box_identifier_array[1]
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
  include params

  # Exec["/usr/bin/apt-get update"] -> Package<| |>

  #include service_cron_up
  include simple_puppet::client


  include conf
  include conf::network::config::no_dhcpcd
  include conf::apt_proxy
  class { 'conf::network':
    interfaces => ['eth0','eth1'],
  }
  
  
  include source_interfaces
  include source_resolv

  include rsyslog
  include monit

  include iptables
  include tor
  include pdnsd

}
