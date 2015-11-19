class privoxy::config (
  $template_name         = $privoxy::template_name,
  $privoxy_user          = $privoxy::privoxy_user,
  $privoxy_ip            = $privoxy::privoxy_ip,
  $privoxy_port          = $privoxy::privoxy_port,
  $tor_ip                = $privoxy::tor_ip,
  $tor_port              = $privoxy::tor_port,
  $tor_oignon_pages_port = $privoxy::tor_oignon_pages_port,
  $polipo_ip             = $privoxy::polipo_ip,
  $polipo_port           = $privoxy::polipo_port,
  $i2p_ip                = $privoxy::i2p_ip,
  $i2p_httpproxy_port    = $privoxy::i2p_httpproxy_port,
  $i2p_webconsole_port   = $privoxy::i2p_webconsole_port,
  $localn                = $privoxy::localn,
  $privaten              = $privoxy::privaten) inherits privoxy {
  file { "/var/log/privoxy": require => User["${privoxy_user}"], }

  file { "/etc/privoxy/config": require => Package[privoxy], }

#  file { "/etc/default/privoxy": }

  File["/var/log/privoxy"] {
    owner   => "${privoxy_user}",
    mode    => "u+rw",
    recurse => true,
  }

#  File["/etc/default/privoxy"] {
#    owner  => root,
#    source => "puppet:///modules/privoxy/privoxy.default",
#    notify => Service["privoxy"],
#  }

  File["/etc/privoxy/config"] {
    content => template("privoxy/${template_name}.erb"),
    notify  => Service["privoxy"],
  }

}