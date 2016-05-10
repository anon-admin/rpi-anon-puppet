define rsyslog::fullfill_service($module = "monit") {
  $service_rotate = $name

  contain rsyslog::install

  file { "/etc/logrotate.d/${service_rotate}":
    owner   => root,
    group   => root,
    mode    => 444,
    source  => "puppet:///modules/${module}/logrotate_${service_rotate}",
    require => [Service["${service_rotate}"], File["/etc/logrotate.d"]],
  }

}