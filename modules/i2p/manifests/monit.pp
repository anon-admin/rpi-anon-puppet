class i2p::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "i2p": 
    module => "i2p",
  }
}