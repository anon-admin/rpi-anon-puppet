class conf::network::dhcpcd inherits conf::network::install::dhcpcd {

  contain conf::network::config::dhcpcd
  contain conf::network::install::dhcpcd_latest

}