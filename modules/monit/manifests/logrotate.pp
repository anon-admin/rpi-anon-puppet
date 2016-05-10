class monit::logrotate {

  rsyslog::fullfill_service{ "monit": module => "monit", } 

}