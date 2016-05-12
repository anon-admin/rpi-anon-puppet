class simple_apt_cacher::monit inherits monit::minimal::config {
  
  monit::fullfill_service{ "apt-cacher-ng": 
    module => "simple_apt_cacher",
  }
}