class pdnsd::install (
  $pdnsd_id = $pdnsd::pdnsd_id, 
  $pdnsd_user = $pdnsd::pdnsd_user,
  $squid_id = $pdnsd::squid_id,
  $squid_user = $pdnsd::squid_user
) inherits pdnsd {
  package { "pdnsd": ensure => latest, }

  user { "${pdnsd_user}": uid => "${pdnsd_id}", }

  exec { ["/usr/local/bin/uidmod.sh ${pdnsd_id} ${pdnsd_user}"]: require => [
      Mount["/usr/local/bin"],
      Package[pdnsd]], }

  exec { "/etc/init.d/pdnsd stop":
    onlyif  => [
      "/etc/init.d/pdnsd status",
      "/usr/bin/test -z \"$( /bin/grep \'^${pdnsd_user}:x:${pdnsd_id}:\' /etc/passwd )\""],
    before  => User["${pdnsd_user}"],
    require => Package[pdnsd],
  }

  User["${pdnsd_user}"] {
    gid     => "${squid_id}",
    ensure  => present,
    require => [Exec["/usr/local/bin/uidmod.sh ${pdnsd_id} ${pdnsd_user}", "/etc/init.d/pdnsd stop"], Group["${squid_user}"]],
    # before  => [Service["pdnsd"], Exec["do iptables"]],
    before  => Service["pdnsd"],
  }
}