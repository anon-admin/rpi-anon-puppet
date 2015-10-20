class rsyslog::logrotate::kdc {

  file { "/etc/logrotate.d/kdc":
    owner   => root,
    require => Package["logrotate","krb5-kdc"],
    #notify  => Service["rsyslog"],
    source  => "puppet://${fqdn}/files/serveur/logrotate_kdc",
  }

}