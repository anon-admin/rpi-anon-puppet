class pdnsd::config (
  $pdnsd_user           = $pdnsd::pdnsd_user,
  $pdnsd_ip             = $pdnsd::pdnsd_ip,
  $pdnsd_port           = $pdnsd::pdnsd_port,
  $tor_ip               = $pdnsd::tor_ip,
  $tor_dns_port         = $pdnsd::tor_dns_port,
  $provider_domain_name = $pdnsd::provider_domain_name,
  $provider_domain      = $pdnsd::provider_domain,
  $prodiver_dns_ip      = $pdnsd::prodiver_dns_ip,
  $prodiver_dns_port    = $pdnsd::prodiver_dns_port,
  $user_localdomain     = $pdnsd::user_localdomain,
  $pdnsd_cachedir       = $pdnsd::pdnsd_cachedir) inherits pdnsd {
       
  file { "${pdnsd_cachedir}": require => User["${pdnsd_user}"], }

  file { "/etc/pdnsd.conf": require => Package[pdnsd], }

  file { "/etc/default/pdnsd": }

  File["/var/cache/pdnsd"] {
    owner   => "${pdnsd_user}",
    mode    => "u+rw",
    recurse => true,
  }

  File["/etc/default/pdnsd"] {
    owner  => root,
    source => "puppet:///modules/pdnsd/pdnsd.default",
    notify  => Service["pdnsd"], }

  File["/etc/pdnsd.conf"] {
    content => template("pdnsd/pdnsd.conf.erb"),
    notify  => Service["pdnsd"],
  }

}