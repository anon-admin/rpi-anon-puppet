class conf::config::systemd inherits conf::install::systemd {
  Package["systemd"] {
    ensure => latest, }

}
