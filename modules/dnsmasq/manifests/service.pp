class dnsmasq::service inherits dnsmasq {
  service { "dnsmasq": require => File[
      "/etc/dnsmasq.conf", "/etc/default/dnsmasq"], }

  Service["dnsmasq"] {
    ensure => running,
    enable => true,
    #before => Service[polipo, pritorxy],
  }
  
  include dnsmasq::monit
}