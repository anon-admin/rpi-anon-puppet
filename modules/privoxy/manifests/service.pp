class privoxy::service inherits privoxy {
  service { "privoxy": require => File[
      "/etc/privoxy/config", "/var/log/privoxy"], }

  Service["privoxy"] {
    ensure => running,
    enable => true,
    #before => Service[polipo, pritorxy],
  }
}