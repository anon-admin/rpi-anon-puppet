class privoxy::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "privoxy": 
    module => "privoxy",
  }
}