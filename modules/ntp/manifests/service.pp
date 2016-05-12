
class ntp::service inherits ntp {  
  service { "ntp":
    enable  => true,
    ensure  => running,
    alias   => "ntpd",
    require => File["/etc/ntp.conf"],
  }
  
  include ntp::monit
}