import "passwords"
import "classes/packages"
import "classes/userids"
import "classes/tor"

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

class package_cron_up inherits package_cron_ {
  Package["cron"] {
    ensure => latest,
  }

}
class service_cron_up inherits service_cron_{

  include package_cron_up

  Service["cron"] {
    ensure => running,
  }

}


node default {

  exec { "/usr/bin/apt-get update":
    provider    => shell,
    refreshonly => true,
    user        => root,
  }

  #Exec["/usr/bin/apt-get update"] -> Package<| |>

  include passwords
  include service_cron_up
  include simple_puppet_client

  include tor

}
