class rsyslog::logrotate::slapd {

  file { "/etc/logrotate.d/slapd":
    owner   => root,
    require => Package["logrotate","slapd"],
    #notify  => Service["rsyslog"],
    source  => "puppet://${fqdn}/files/serveur/logrotate_slapd",
  }

}