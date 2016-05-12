class monit::config inherits monit::minimal::config {
  contain monit::install

  file { "/etc/monit/monitrc":
    owner   => root,
    group   => root,
    mode    => 400,
    notify  => Service["monit"],
    source  => "puppet:///modules/monit/monitrc",
    require => [Package["monit"], File["/etc/monit/monitrc.d"]],
  }

}