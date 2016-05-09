class conf::network::install::bridge_latest inherits conf::network::install::bridge {

  Package["bridge-utils"] {
    ensure => latest,
  }

}