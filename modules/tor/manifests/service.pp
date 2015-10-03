class tor::service($tor_user = $tor::tor_user) inherits tor {
  service { "tor":
    ensure  => running,
    enable  => true,
    require => [File["/etc/default/tor", "/etc/tor/torrc"], Exec["sticky on /var/log/tor"], User["${tor_user}"]],
  }
}