class conf::config::git inherits conf::install::git {
  Package["git"] {
    ensure => latest, }

}

