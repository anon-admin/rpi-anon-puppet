class rsyslog::logrotate::vsftpd {

  file { "/etc/logrotate.d/vsftpd":
    owner   => root,
    require => Package["logrotate","vsftpd"],
    #notify  => Service["rsyslog"],
    source  => "puppet://${fqdn}/files/serveur/logrotate_vsftpd",
  }

}