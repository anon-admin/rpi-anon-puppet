class rsyslog::logrotate::sshd {

  file { "/etc/logrotate.d/ssh":
    owner   => root,
    require => Package["logrotate","openssh-client","openssh-server"],
    notify  => Service["rsyslog"],
    source  => "/etc/puppet/files/ssh/logrotate_ssh",
  }

}
