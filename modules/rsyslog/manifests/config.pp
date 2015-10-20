class rsyslog::config inherits rsyslog::install {
  file { "/etc/cron.hourly/logrotate":
    owner => root,
    group => root,
    mode  => 755,
    source => "/etc/cron.daily/logrotate",
    before => File["/etc/cron.daily/logrotate"],
  }

  file { "/etc/cron.daily/logrotate":
    ensure => absent,
  }
}