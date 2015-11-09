class dnsmasq::config (
  $dnsmasq_if_privaten     = $dnsmasq::dnsmasq_if_privaten,
  $dnsmasq_domain_privaten = $dnsmasq::dnsmasq_domain_privaten,
  $dnsmasq_privaten        = $dnsmasq::dnsmasq_privaten,
  $dnsmasq_routeur         = $dnsmasq::dnsmasq_routeur,
  $dnsmasq_ntpserv         = $dnsmasq::dnsmasq_ntpserv) inherits dnsmasq {
       
  file { "/etc/dnsmasq.conf": require => Package[dnsmasq], }

  file { "/etc/default/dnsmasq": }

  File["/etc/default/dnsmasq"] {
    owner  => root,
    source => "puppet:///modules/dnsmasq/dnsmasq.default",
    notify  => Service["dnsmasq"], }

  File["/etc/dnsmasq.conf"] {
    content => template("dnsmasq/dnsmasq.conf.erb"),
    notify  => Service["dnsmasq"],
  }

}