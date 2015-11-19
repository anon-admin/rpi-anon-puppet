class polipo::config (
  $tor_ip                = $polipo::tor_ip,
  $tor_port              = $polipo::tor_port
) inherits polipo {
    
  file { "/etc/polipo/config": require => Package[polipo], }

  File["/etc/polipo/config"] {
    content => template("polipo/config.erb"),
    notify  => Service["polipo"],
  }

}