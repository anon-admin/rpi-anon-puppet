define monit::make_available {
  $to_avail = $name

  include monit::minimal::config

  file { "/etc/monit/conf.d/${to_avail}":
    ensure  => link,
    target  => "../monitrc.d/${to_avail}",
    require => File["/etc/monit/monitrc.d/${to_avail}", "/etc/monit/conf.d"],
  }

}