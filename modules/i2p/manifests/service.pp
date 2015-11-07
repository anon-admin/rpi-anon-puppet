class i2p::service inherits i2p {
  service { "i2p": require => File[
    "/etc/i2p/wrapper.config",
    "${i2p_home}/i2p-config/clients.config",
    "${i2p_home}/i2p-config/i2ptunnel.config"], }

  Service["i2p"] {
    ensure => running,
    enable => true,
    #before => Service[polipo, pritorxy],
  }
}