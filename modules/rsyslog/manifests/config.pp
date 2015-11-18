class rsyslog::config inherits rsyslog::install {
  file { "/etc/cron.hourly/logrotate":
    owner => root,
    group => root,
    mode  => 755,
    source => "/etc/cron.daily/logrotate",
    before => File["/etc/cron.daily/logrotate"],
    require => Package["logrotate"]
  }

  file { "/etc/cron.daily/logrotate":
    ensure => absent,
  }
  
  exec { "/bin/sed -i 's/monthly/weekly/' /etc/logrotate.conf":
    provider => shell,
    cwd => "/tmp",
    require => Package["logrotate"],
  }
}