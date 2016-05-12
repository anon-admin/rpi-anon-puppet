class polipo::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "polipo": 
    module => "polipo",
  }
}