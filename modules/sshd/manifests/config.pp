class sshd::config () inherits sshd::install {
       
  file { "/etc/ssh": ensure=> directory, }
  file { "/etc/ssh/sshd_config": ensure=> present, }

  Package["openssh-server"] -> File["/etc/ssh"] -> File["/etc/ssh/sshd_config"]

}