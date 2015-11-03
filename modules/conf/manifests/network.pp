class conf::network inherits conf {
  contain conf::network::resolv
  contain conf::network::interfaces
  case $lsbdistcodename {
    'jessie': {
      contain conf::network::dhcpcd
    }
  }
}