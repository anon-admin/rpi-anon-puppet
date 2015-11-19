class simple_apt_cacher::service ($proxy_ip, $proxy_port, $acng_user = $simple_apt_cacher::acng_user) inherits simple_apt_cacher::config {

  contain simple_apt_cacher::clean

  file { ["/var/log/apt-cacher-ng", "/var/cache/apt-cacher-ng"]: 
    ensure => directory,
    group  => "${acng_user}",
    mode   => "g+w",    
  }

  file { "/etc/apt-cacher-ng/acng.conf":
    owner => root,
    group => root,
    mode  => 444,
    notify => Service["apt-cacher-ng"],
    content => template("simple_apt_cacher/acng.conf.erb"),
  }

  service { "apt-cacher-ng":
    ensure  => running,
    enable  => true,
    require => [
      File["/etc/apt-cacher-ng/acng.conf"],
      User["${acng_user}"]],
  }
  
}