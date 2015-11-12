class simple_apt_cacher::config inherits simple_apt_cacher {
  contain simple_apt_cacher::user::definition

  Package["apt-cacher-ng"] {
    ensure => latest, }

  File["/etc/default/apt-cacher-ng"] {
    ensure => file,
    source => "puppet:///modules/simple_apt_cacher/acng-default",
  }

}