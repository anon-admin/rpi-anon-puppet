class sshd::install () inherits sshd {
  package { "openssh-server": ensure => latest, }

}