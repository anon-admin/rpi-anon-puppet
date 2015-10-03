class conf::config::sysvinit inherits conf::install::sysvinit {
  Package["sysvinit"] {
    ensure => latest, }

}
