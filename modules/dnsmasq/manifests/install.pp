class dnsmasq::install (
  $dnsmasq_id = $dnsmasq::dnsmasq_id, 
  $dnsmasq_user = $dnsmasq::dnsmasq_user
) inherits dnsmasq {
  package { "dnsmasq": ensure => latest, }

  user { "${dnsmasq_user}": uid => "${dnsmasq_id}", }

  exec { ["/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}"]: require => [
      Mount["/usr/local/bin"],
      Package[dnsmasq]], }

  exec { "/usr/sbin/service dnsmasq stop":
    onlyif  => [
      "/usr/sbin/service dnsmasq status",
      "/usr/bin/test -z \"$( /bin/grep \'^${dnsmasq_user}:x:${dnsmasq_id}:\' /etc/passwd )\""],
    before  => User["${dnsmasq_user}"],
    require => Package[dnsmasq],
  }

  User["${dnsmasq_user}"] {
    gid     => 65534,
    ensure  => present,
    require => [Exec["/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}", "/usr/sbin/service dnsmasq stop"]],
    # before  => [Service["dnsmasq"], Exec["do iptables"]],
    before  => Service["dnsmasq"],
  }
}