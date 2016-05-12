class polipo::service inherits polipo {
  service { "polipo": require => File["/etc/polipo/config"], }

  Service["polipo"] {
    ensure => running,
    enable => true,
  # before => Service[polipo, pritorxy],
  }
  
  include polipo::monit
}