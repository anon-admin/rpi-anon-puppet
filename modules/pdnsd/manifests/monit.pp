class pdnsd::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "pdnsd": 
    module => "pdnsd",
  }
}