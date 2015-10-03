
class simple_puppet::service::no inherits simple_puppet::service {

  File["/etc/default/puppet"] {
    require => Package["puppet"],
    source => "puppet:///modules/simple_puppet/no-auto-start",
  }
                 
  Service[puppet] {
    enable => false,
    ensure => stopped,
  }

}