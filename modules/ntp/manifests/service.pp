
class ntp::service inherits ntp {  
  service { "ntp":
    enable  => true,
    ensure  => running,
    require => File["/etc/ntp.conf"],
  }
  
  include ntp::monit
}