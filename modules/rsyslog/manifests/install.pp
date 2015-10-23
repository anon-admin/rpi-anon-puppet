class rsyslog::install {
    package { ["rsyslog","logrotate"]:
    ensure => latest,
  }
}