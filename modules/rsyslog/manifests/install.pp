class rsyslog::install {
  package { ["rsyslog", "logrotate"]: ensure => latest, }
  Exec["/usr/bin/apt-get update"] -> Package["rsyslog"] -> Package["logrotate"]

  include conf::config::apt

  file { "/etc/logrotate.d":
    ensure => directory,
  }
  Package["logrotate"] -> File["/etc/logrotate.d"]
  
}