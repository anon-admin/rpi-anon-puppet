class conf::network::config::dhcpcd {

  file { "/etc/dhcpcd.conf":
    mode  => 444,
    owner => root,
    group => netdev,
  }
  Package["dhcpcd5"] -> File["/etc/dhcpcd.conf"]

}