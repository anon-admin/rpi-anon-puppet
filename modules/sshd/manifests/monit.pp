class sshd::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "openssh-server": 
    module => "sshd",
  }
}