class simple_puppet::service {
  service { puppet:
  }

  file { "/etc/default/puppet":
    mode => 644,
    owner => root,
    group => root,
  }
}


