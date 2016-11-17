class conf::network::install::dhcpcd_latest inherits conf::network::install::dhcpcd {

  Package["dhcpcd5"] {
    ensure => latest,
  }

}