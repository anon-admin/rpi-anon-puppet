class rsyslog::logrotate::rsyslog {

  rsyslog::fullfill_service{ "rsyslog": module => "rsyslog", } 
  
  service { "rsyslog":
    ensure => running,
  }
  Package["rsyslog"] -> Service["rsyslog"]

}