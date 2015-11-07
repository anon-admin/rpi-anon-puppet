class conf::network($has_ipv6 = false, $interfaces = ['eth0']) inherits conf {
  contain conf::network::resolv
  contain conf::network::interfaces
  
  if $has_ipv6 == false {
      class { 'conf::network::sysctl': 
        source     => 'noipv6.conf',
        interfaces => $interfaces,
      }
  }
  
  case $lsbdistcodename {
    'jessie': {
      contain conf::network::dhcpcd
    }
  }
}