class rsyslog::install {
  package { ["rsyslog", "logrotate"]: ensure => latest, }
  Exec["/usr/bin/apt-get update"] -> Package["rsyslog"] -> Package["logrotate"]
}