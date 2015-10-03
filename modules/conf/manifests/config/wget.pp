class conf::config::wget inherits conf::install::wget {
  Package["wget"] {
    ensure => latest, }

}
