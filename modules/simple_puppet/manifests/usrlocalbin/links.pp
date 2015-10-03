class simple_puppet::usrlocalbin::links {
  file { ["/etc/puppet/scripts/uidmod.sh", "/etc/puppet/scripts/gidmod.sh"]: mode => "a+x", }

  file { "/usr/local/bin/uidmod.sh":
    ensure => link,
    target => "/etc/puppet/scripts/uidmod.sh",
    before => Mount["/usr/local/bin"],
  }

  file { "/usr/local/bin/gidmod.sh":
    ensure => link,
    target => "/etc/puppet/scripts/gidmod.sh",
    before => Mount["/usr/local/bin"],
  }

  mount { "/usr/local/bin":
    atboot => false,
    ensure => absent,
  }
}