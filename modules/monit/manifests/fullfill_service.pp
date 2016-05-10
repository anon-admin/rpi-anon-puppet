define monit::fullfill_service($module = "monit") {
  $service_tocheck = $name

  include monit::minimal::service

  file { "/etc/monit/monitrc.d/${service_tocheck}":
    owner   => root,
    group   => root,
    mode    => 444,
    source  => "puppet:///modules/${module}/${service_tocheck}.monit.${lsbdistcodename}",
    notify  => Service["monit"],
    require => [Service["${service_tocheck}"], File["/etc/monit/monitrc.d"]],
  }

  monit::make_available { "${service_tocheck}": }

}