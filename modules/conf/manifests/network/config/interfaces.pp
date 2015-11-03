class conf::network::config::interfaces {

  file { "/etc/network/interfaces":
    mode  => 444,
    owner => root,
    group => root,
  }

}