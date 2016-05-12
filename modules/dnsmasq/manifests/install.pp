class dnsmasq::install (
  $dnsmasq_id = $dnsmasq::dnsmasq_id, 
  $dnsmasq_user = $dnsmasq::dnsmasq_user
) inherits dnsmasq {
  package { "dnsmasq": ensure => latest, }

  user { "${dnsmasq_user}": uid => "${dnsmasq_id}", }

  exec { ["/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}"]: require => [
      Mount["/usr/local/bin"],
      Package[dnsmasq]], }

  exec { "/etc/init.d/dnsmasq stop":
    onlyif  => [
      "/etc/init.d/dnsmasq status",
      "/usr/bin/test -z \"$( /bin/grep \'^${dnsmasq_user}:x:${dnsmasq_id}:\' /etc/passwd )\""],
    before  => User["${dnsmasq_user}"],
    require => Package[dnsmasq],
  }

  User["${dnsmasq_user}"] {
    gid     => 65534,
    ensure  => present,
    require => [Exec["/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}", "/etc/init.d/dnsmasq stop"]],
    # before  => [Service["dnsmasq"], Exec["do iptables"]],
    before  => Service["dnsmasq"],
  }
}