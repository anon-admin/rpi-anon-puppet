class conf::network::config::resolv {

  file { "/etc/resolv.conf":
    mode  => 444,
    owner => root,
    group => root,
  }

}