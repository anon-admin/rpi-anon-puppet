class conf::config::apt inherits conf::install::apt {
  Package["apt"] {
    ensure => latest, }

  file { "/etc/cron.daily/apt":
    ensure  => present,
    require => Package["apt", "cron"],
  }

  file { "/etc/apt/apt.conf.d/02periodic":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/conf/apt_conf_02periodic",
    require => [File["/etc/cron.daily/apt"], Service["cron"]],
  }

}

