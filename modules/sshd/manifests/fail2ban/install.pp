class sshd::fail2ban::install () inherits sshd {
  package { "fail2ban": ensure => latest, }

}