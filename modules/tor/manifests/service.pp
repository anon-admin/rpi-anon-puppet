class tor::service($tor_user = $tor::tor_user) inherits tor {
  file { "/var/run/tor":
    ensure => directory,
    owner  => $tor_user,
    group  => $tor_user,
  }

  service { "tor":
    ensure  => running,
    enable  => true,
    require => [File["/etc/default/tor", "/etc/tor/torrc", "/var/run/tor"], Exec["sticky on /var/log/tor"], User["${tor_user}"]],
    provider => debian,
  }
  
  include tor::monit
  include tor::logrotate
}