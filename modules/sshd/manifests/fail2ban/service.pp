class sshd::fail2ban::service inherits sshd::fail2ban::config {
  service { "fail2ban": require => File["/etc/fail2ban/fail2ban.conf"], }

  Service["fail2ban"] {
    ensure => running,
    enable => true,
  }
  
  include sshd::fail2ban::monit
  include sshd::fail2ban::logrotate
  
}