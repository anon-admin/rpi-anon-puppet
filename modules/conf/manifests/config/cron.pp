class conf::config::cron inherits conf::service::cron {
  Package["cron"] {
    ensure => latest, }

  file { "/etc/cron.daily":
    ensure  => directory,
    require => Package["cron"],
  }

  Service["cron"] {
    ensure  => running,
    enable  => true,
    require => File["/etc/cron.daily"],
  }

}