class tor::logrotate {

  rsyslog::fullfill_service{ "tor": module => "tor", } 

}