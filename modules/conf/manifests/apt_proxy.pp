class conf::apt_proxy ($routeur) inherits conf::install::apt {
  file { "/etc/apt/apt.conf.d":
    ensure  => directory,
    require => Package["apt"],
  }

  file { "/etc/apt/apt.conf.d/00proxy":
    ensure  => absent,
    require => Package["apt"],
  }

  case $hostname {
    $routeur : {
      file { "/etc/apt/apt.conf.d/01proxy": source => "puppet:///modules/conf/apt_conf_01proxy_localhost", }
    }
    default  : {
      file { "/etc/apt/apt.conf.d/01proxy": content => template("conf/apt_conf_01proxy.erb"), }
    }
  }
  Package["apt"] -> File["/etc/apt/apt.conf.d/01proxy"]

  tidy { "/var/cache/apt/archives":
    age     => "1m",
    recurse => 1,
    backup  => false,
    matches => "*.deb",
    require => File["/etc/apt/apt.conf.d/01proxy"],
  }

}
