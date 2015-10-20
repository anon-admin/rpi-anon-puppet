class rsyslog::monit inherits monit::minimal::config {
  monit::fullfill_service { "rsyslog": module => "rsyslog", }

}