class ntp::config($ntp_hwsync, $ntp_hw_stratum, $ntp_servers) inherits ntp {

  file { "/etc/ntp.conf":
    owner => root,
    group => root,
    mode => 444,
    require => Package["ntp"],
  }
      

  File["/etc/ntp.conf"] {
    content => template("ntp/ntp.conf.erb"),
    notify => Service["ntp"],
  }

}