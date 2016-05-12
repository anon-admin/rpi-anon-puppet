class sshd::fail2ban::config () inherits sshd::fail2ban::install {
       
  file { "/etc/fail2ban": ensure=> directory, }
  file { "/etc/fail2ban/fail2ban.conf": ensure=> present, }

  Package["fail2ban"] -> File["/etc/fail2ban"] -> File["/etc/fail2ban/fail2ban.conf"]

}