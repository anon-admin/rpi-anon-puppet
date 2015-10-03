class simple_puppet::service {
  service { puppet:
  }

  file { "/etc/default/puppet":
    mode => 644,
    owner => root,
    group => root,
  }
}

class simple_puppet::no_service inherits simple_puppet::service {

  File["/etc/default/puppet"] {
    require => Package["puppet"],
    source => "/etc/puppet/files/puppet/no-auto-start",
  }
                 
  Service[puppet] {
    enable => false,
    ensure => stopped,
  }

}

