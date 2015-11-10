class polipo::config (
  $tor_ip                = $polipo::tor_ip,
  $tor_port              = $polipo::tor_port
) inherits polipo {
    
  file { "/etc/polipo/torconf": require => Package[polipo], }

  File["/etc/polipo/torconf"] {
    content => template("polipo/torconf.erb"),
    notify  => Service["polipo"],
  }

}