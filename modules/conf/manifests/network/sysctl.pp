class conf::network::sysctl($source, $interfaces) {
  file { "/etc/sysctl.d/${source}":
    content => template("/conf/${source}.erb"),
  }

}