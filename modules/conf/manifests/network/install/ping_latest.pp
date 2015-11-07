class conf::network::install::ping_latest inherits conf::network::install::ping {

  Package["iputils-ping"] {
    ensure => latest,
  }

}