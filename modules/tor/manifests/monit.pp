class tor::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "tor": 
    module => "tor",
  }
}