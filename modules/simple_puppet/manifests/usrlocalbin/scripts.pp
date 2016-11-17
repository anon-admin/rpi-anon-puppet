class simple_puppet::usrlocalbin::scripts {
  file { ["/etc/puppet/scripts/uidmod.sh", "/etc/puppet/scripts/gidmod.sh"]:
    mode => "a+x",
  }


}