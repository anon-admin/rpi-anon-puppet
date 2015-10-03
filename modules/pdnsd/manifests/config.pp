class pdnsd::config($pdnsd_user = $pdnsd::pdnsd_user,
  $pdnsd_ip = $pdnsd::pdnsd_ip,
     $pdnsd_port = $pdnsd::pdnsd_port,
     $tor_ip = $pdnsd::tor_ip,
     $tor_dns_port = $pdnsd::tor_dns_port) inherits pdnsd {
       
  file { "/var/cache/pdnsd": require => User["${pdnsd_user}"], }

  file { "/etc/pdnsd.conf": require => Package[pdnsd], }

  file { "/etc/default/pdnsd": }

  File["/var/cache/pdnsd"] {
    owner   => "${pdnsd_user}",
    mode    => "u+rw",
    recurse => true,
  }

  File["/etc/default/pdnsd"] {
    owner  => root,
    source => "puppet:///modules/pdnsd/pdnsd.default", }

  File["/etc/pdnsd.conf"] {
    content => template("pdnsd/pdnsd.conf.erb"),
    notify  => Service["pdnsd"],
  }

}