class conf::config::apt inherits conf::install::apt {
  Package["apt"] {
    ensure => latest, }

  if ("$::operatingsystem" == "Debian") {
    exec { "/usr/bin/apt-get -q -y --force-yes -o DPkg::Options::=--force-confold install ${::lsbdistid}-archive-keyring":
      before => Package["apt"],
      cwd => '/tmp',
      provider => shell,
    }
  }

  file { "/etc/cron.daily/apt":
    ensure  => present,
    require => Package["apt", "cron"],
  }

  include conf::install::cron

  file { "/etc/apt/apt.conf.d/02periodic":
    owner   => root,
    group   => root,
    mode    => 644,
    source  => "puppet:///modules/conf/apt_conf_02periodic",
    require => [File["/etc/cron.daily/apt"], Service["cron"]],
  }

  include conf::service::cron

  exec { "/usr/bin/apt-get update":
    provider    => shell,
    refreshonly => true,
    user        => root,
  }

}

