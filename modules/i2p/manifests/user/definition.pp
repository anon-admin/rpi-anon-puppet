class i2p::user::definition (
  $i2p_user = $i2p::i2p_user, 
  $i2p_id = $i2p::i2p_id,
  $i2p_home = $i2p::i2p_home
) inherits i2p {
  exec { [
    "/usr/local/bin/gidmod.sh ${i2p_id} ${i2p_user}",
    "/usr/local/bin/uidmod.sh ${i2p_id} ${i2p_user}"]: require => Mount["/usr/local/bin"], }

  group { "${i2p_user}":
    ensure  => present,
    gid     => "${i2p_id}",
    require => Exec["/usr/local/bin/gidmod.sh ${i2p_id} ${i2p_user}"],
    before  => Package["i2p"],
  }

  user { "${i2p_user}":
    ensure  => present,
    uid     => "${i2p_id}",
    gid     => "${i2p_user}",
    home    => "${i2p_home}",
    shell   => "/bin/false",
    require => [Exec["/usr/local/bin/uidmod.sh ${i2p_id} ${i2p_user}"], Group["${i2p_user}"]],
    before  => [Package["i2p"], Service["i2p"]],
  }

}
