class sshd::service inherits sshd::config {
  service { "ssh": require => File["/etc/ssh/sshd_config"], }

  Service["ssh"] {
    ensure => running,
    enable => true,
    alias => "openssh-server",
  }
  
  include sshd::monit
  include sshd::fail2ban::service
  
}