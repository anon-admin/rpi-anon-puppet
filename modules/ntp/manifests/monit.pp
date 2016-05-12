class ntp::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "ntpd": 
    module => "ntp",
  }
}