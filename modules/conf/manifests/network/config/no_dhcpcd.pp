class conf::network::config::no_dhcpcd inherits conf::network::config::dhcpcd {

  File["/etc/dhcpcd.conf"] {
        source => "puppet:///modules/conf/no_dhcpcd.conf",
  }

}