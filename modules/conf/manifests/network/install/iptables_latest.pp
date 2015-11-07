class conf::network::install::iptables_latest inherits conf::network::install::iptables {

  Package["iptables"] {
    ensure => latest,
  }

}