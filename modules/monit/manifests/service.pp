class monit::service inherits monit::minimal::service {
  
  contain monit::config
  
  Service["monit"] {
    enable => true,
    ensure => running,
  }
  
  include monit::logrotate
}