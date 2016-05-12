class pdnsd::service inherits pdnsd {
  service { "pdnsd": require => File[
      "/etc/pdnsd.conf", "/var/cache/pdnsd", "/etc/default/pdnsd"], }

  Service["pdnsd"] {
    ensure => running,
    enable => true,
    #before => Service[polipo, pritorxy],
  }
  
  include pdnsd::monit
}