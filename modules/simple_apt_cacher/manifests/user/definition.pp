class simple_apt_cacher::user::definition ($acng_user = $simple_apt_cacher::acng_user, $acng_id = $simple_apt_cacher::acng_id) inherits simple_apt_cacher {
  exec { ["/usr/local/bin/gidmod.sh ${acng_id} ${acng_user}", "/usr/local/bin/uidmod.sh ${acng_id} ${acng_user}"]: require => Mount[
      "/usr/local/bin"], }

  group { "${acng_user}":
    ensure  => present,
    gid     => "${acng_id}",
    require => Exec["/usr/local/bin/gidmod.sh ${acng_id} ${acng_user}"],
    before  => Package[apt-cacher-ng],
  }

  user { "${acng_user}":
    ensure  => present,
    uid     => "${acng_id}",
    gid     => "${acng_user}",
    require => [Exec["/usr/local/bin/uidmod.sh ${acng_id} ${acng_user}"], Group["${acng_user}"]],
    before  => [Package[apt-cacher-ng], Service["apt-cacher-ng"]],
  }

}
