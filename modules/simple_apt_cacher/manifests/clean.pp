class simple_apt_cacher::clean {

  tidy { "/var/log/apt-cacher-ng":
    recurse => true,
    backup  => false,
    age     => "1w",
    require => File["/var/log/apt-cacher-ng"],
  }
    
}