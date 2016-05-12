class sshd::fail2ban::logrotate {

  rsyslog::fullfill_service{ "fail2ban": module => "sshd", } 

}