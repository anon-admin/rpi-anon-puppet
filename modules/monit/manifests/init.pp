# Class: monit
#
# This module manages monit
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class monit {
  contain monit::service
}






#class monit_bind inherits install_monit_minimum_ {
#  file { "/etc/monit/monitrc.d/bind9":
#    owner => root,
#    group => root,
#    mode => 444,
#    source => "puppet://puppet/files/routeur/monit/bind9",
#    notify => Service["monit"],
#    require => [ Service["bind9"], File["/etc/monit/monitrc.d"] ],
#  }
#  
#}
#
#class monit_apache inherits install_monit_minimum_ {
#  
#  include apache_conf_const_
#  $apache_pidfile=$apache_conf_const_::apache_pidfile
#
#  file { "/etc/monit/monitrc.d/apache2":
#    ensure  => present,
#    mode    => 700,
#    owner   => root,
#    group   => root,
#    notify  => Service["monit"],
#    content => template("serveur/monit/apache2.erb"),
#    require => [ Service["apache2"], File["/etc/monit/monitrc.d"] ],
#  }
#
#  install_monit_minimum_::monit_make_available{ "apache2": }
#
#}
#
#class monit_slapd inherits install_monit_minimum_ {
#  file { "/etc/monit/monitrc.d/slapd":
#    owner => root,
#    group => root,
#    mode => 444,
#    source => "puppet://atm2.atm2.com/files/serveur/monit/slapd",
#    notify => Service["monit"],
#    require => [ Service["slapd"], File["/etc/monit/monitrc.d"] ],
#  }
#  
#}
#
#class monit_vsftpd inherits install_monit_minimum_ {
#  file { "/etc/monit/monitrc.d/vsftpd":
#    owner => root,
#    group => root,
#    mode => 444,
#    source => "puppet://puppet/files/serveur/monit/vsftpd",
#    notify => Service["monit"],
#    require => [ Service["vsftpd"], File["/etc/monit/monitrc.d"] ],
#  }
#  
#}







#
#
#class monit_nfs_kernel_serveur inherits install_monit_minimum_ {
#
#  install_monit_minimum_::monit_fullfill_service{ "nfs-kernel-server": }
#  
#}
#
#class monit_ssh inherits install_monit_minimum_ {
#
#  install_monit_minimum_::monit_fullfill_service{ "ssh": }
#  
#}
#

