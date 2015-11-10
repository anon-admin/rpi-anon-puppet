class privoxy::install (
  $privoxy_id = $privoxy::privoxy_id, 
  $privoxy_user = $privoxy::privoxy_user
) inherits privoxy {
  package { "privoxy": ensure => latest, }

  user { "${privoxy_user}": uid => "${privoxy_id}", }

  exec { ["/usr/local/bin/uidmod.sh ${privoxy_id} ${privoxy_user}"]: require => [
      Mount["/usr/local/bin"],
      Package[privoxy]], }

  exec { "/usr/sbin/service privoxy stop":
    onlyif  => [
      "/usr/sbin/service privoxy status",
      "/usr/bin/test -z \"$( /bin/grep \'^${privoxy_user}:x:${privoxy_id}:\' /etc/passwd )\""],
    before  => User["${privoxy_user}"],
    require => Package[privoxy],
  }

  User["${privoxy_user}"] {
    gid     => 65534,
    ensure  => present,
    require => Exec["/usr/local/bin/uidmod.sh ${privoxy_id} ${privoxy_user}", "/usr/sbin/service privoxy stop"],
    # before  => [Service["privoxy"], Exec["do iptables"]],
    before  => Service["privoxy"],
  }
}