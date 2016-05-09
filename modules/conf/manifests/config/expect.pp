class conf::config::expect inherits conf::install::expect {
  Package["expect"] {
    ensure => latest, }

}
