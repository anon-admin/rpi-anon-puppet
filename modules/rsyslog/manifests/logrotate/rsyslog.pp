class rsyslog::logrotate::rsyslog {

  file { "/etc/logrotate.d/rsyslog":
    owner   => root,
    require => Package["logrotate","rsyslog"],
    #notify  => Service["rsyslog"],
    source  => "puppet:///modules/rsyslog/logrotate_rsyslog",
  }

}