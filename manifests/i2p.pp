import "passwords"

class simple_puppet::params {
  include userids

  $puppetadmin_user = $userids::puppetadmin_user
  $puppetadmin_id = $userids::puppetadmin_id
  $puppetadmin_shell = '/bin/false'

  $reports_dir = "/var/lib/puppet/reports"
  $clientbucket_dir = "/var/lib/puppet/clientbucket"

  $box_identifier_array = split($hostname, "_")
  $manifest = $box_identifier_array[1]

}

class userids::params {
  include passwords

  $admin_pwd = $passwords::admin_pwd
  $admin_pwd_cr = $passwords::admin_pwd_cr
}




class proxy_base($proxy_id = $userids::conf::proxygroup::proxy_id,
  $proxy_group = $userids::conf::proxygroup::proxy_group) inherits userids::conf::proxygroup {


  exec { "/usr/local/bin/gidmod.sh ${proxy_id} ${proxy_group}": require => Mount["/usr/local/bin"], }

  Group["${proxy_group}"] {
    ensure => present,
  }
  Exec["/usr/local/bin/gidmod.sh ${proxy_id} ${proxy_group}"] -> Group["${proxy_group}"]

  
}

node default {
  exec { "/usr/bin/apt-get update":
    provider    => shell,
    refreshonly => true,
    user        => root,
  }


  # Exec["/usr/bin/apt-get update"] -> Package<| |>

  include simple_puppet::client

  include proxy_base
  include conf
  # no headless because of jdk oracle - include conf::headless
  include rsyslog
  
  class { 'conf::apt_proxy': routeur => "192.168.1.2", }
  
  include i2p

}
