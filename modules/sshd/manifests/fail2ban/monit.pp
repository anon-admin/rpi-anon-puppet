class sshd::fail2ban::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "fail2ban": 
    module => "sshd",
  }
}