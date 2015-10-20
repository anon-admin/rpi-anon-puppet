class rsyslog::logrotate::apache2 {

  file { "/etc/logrotate.d/apache2":
    owner   => root,
    require => Package["logrotate","apache2"],
    #notify  => Service["rsyslog"],
    source  => "/etc/puppet/files/serveur/logrotate_apache2",
  }

}