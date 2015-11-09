class ntp::install inherits ntp {
  package { "ntp":
    ensure => latest,
    require => File["/etc/apt/apt.conf.d/02periodic"],
  }

}