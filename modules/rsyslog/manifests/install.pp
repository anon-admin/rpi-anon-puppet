class rsyslog::install {
  package { ["rsyslog", "logrotate"]: ensure => latest, }
  Exec["/usr/bin/apt-get update"] -> Package["rsyslog"] -> Package["logrotate"]
  
  file { "/etc/logrotate.d":
    ensure => directory,
  }
  Package["logrotate"] -> File["/etc/logrotate.d"]
  
}