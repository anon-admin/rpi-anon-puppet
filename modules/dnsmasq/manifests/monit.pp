class dnsmasq::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "dnsmasq": 
    module => "dnsmasq",
  }
}