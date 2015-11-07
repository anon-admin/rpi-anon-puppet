class i2p::mounts (
  $i2p_user       = $i2p::i2p_user,
  $i2p_home       = $i2p::i2p_home,
  $i2p_mountpoint = $i2p::i2p_mountpoint) inherits i2p {
  file { "${i2p_mountpoint}": ensure => directory, }

  file { ["${i2p_mountpoint}/config", "${i2p_mountpoint}/log", "${i2p_mountpoint}/etc", "${i2p_mountpoint}/home"]:
    ensure  => directory,
    require => Mount["${i2p_mountpoint}"],
  }

  File[
    "/etc/i2p", "/var/log/i2p", "${i2p_home}", "/usr/share/i2p"] {
    ensure => directory,
    group  => "${i2p_user}",
    mode   => "g+w",
  }
  Group["${i2p_user}"] -> File["/etc/i2p"]
  Group["${i2p_user}"] -> File["/var/log/i2p"]
  Group["${i2p_user}"] -> File["${i2p_home}"]
  Group["${i2p_user}"] -> File["/usr/share/i2p"]

  File["/var/log/i2p", "${i2p_home}"] {
    user => "${i2p_user}", }
  User["${i2p_user}"] -> File["/var/log/i2p"]
  User["${i2p_user}"] -> File["${i2p_home}"]


  mount { "/etc/i2p":
    device  => "${i2p_mountpoint}/etc",
    require => [File["/etc/i2p", "${i2p_mountpoint}/etc"], Mount["${i2p_mountpoint}"]],
  }

  mount { "/var/log/i2p":
    device  => "${i2p_mountpoint}/log",
    require => [File["/var/log/i2p", "${i2p_mountpoint}/log"], Mount["${i2p_mountpoint}"]],
  }

  mount { "${i2p_home}":
    device  => "${i2p_mountpoint}/home",
    require => [File["${i2p_home}", "${i2p_mountpoint}/home"], Mount["${i2p_mountpoint}"]],
  }

  mount { "/usr/share/i2p":
    device  => "${i2p_mountpoint}/config",
    require => [File["/usr/share/i2p", "${i2p_mountpoint}/config"], Mount["${i2p_mountpoint}"]],
  }

  Mount[
    "/etc/i2p", "/var/log/i2p", "${i2p_home}", "/usr/share/i2p"] {
    fstype  => none,
    options => "bind,rw",
    before  => Package["i2p"],
    atboot  => true,
    ensure  => mounted,
  }

  contain i2p::clean
}
