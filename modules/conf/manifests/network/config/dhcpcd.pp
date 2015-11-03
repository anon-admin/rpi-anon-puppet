class conf::network::config::dhcpcd {

  file { "/etc/dhcpcd.conf":
    mode  => 444,
    owner => root,
    group => root,
  }

}