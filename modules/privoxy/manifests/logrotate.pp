class privoxy::logrotate {

  rsyslog::fullfill_service{ "privoxy": module => "privoxy", } 

}