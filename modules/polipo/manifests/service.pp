class polipo::service inherits polipo {
  service { "polipo": require => File["/etc/polipo/torconf"], }

  Service["polipo"] {
    ensure => running,
    enable => true,
  # before => Service[polipo, pritorxy],
  }
}