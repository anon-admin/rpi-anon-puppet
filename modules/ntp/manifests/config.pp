class ntp::config(
  $ntp_hwsync = $ntp::ntp_hwsync, 
  $ntp_hw_stratum = $ntp::ntp_hw_stratum, 
  $ntp_interface = $ntp::ntp_interface, 
  $ntp_options = $ntp::ntp_options, 
  $ntp_servers = $ntp::ntp_servers
) inherits ntp {

  file { ["/etc/ntp.conf","/etc/default/ntp"]:
    owner => root,
    group => root,
    mode => 444,
    require => Package["ntp"],
    notify => Service["ntp"],
  }
      

  File["/etc/ntp.conf"] {
    content => template("ntp/ntp.conf.erb"),
  }
  File["/etc/default/ntp"] {
    content => template("ntp/ntp.default.erb"),
  }

}