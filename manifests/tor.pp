import "passwords"
import "classes/simple_puppet"
import "classes/packages"
import "classes/userids"

class puppet_consts_ {

     include userids

     $puppetadmin_user = $userids::puppetadmin_user
     $puppetadmin_id = $userids::puppetadmin_id
     $puppetadmin_shell = '/bin/false'

    $reports_dir = "/var/lib/puppet/reports"

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

  Package<| |> -> Exec["/usr/bin/apt-get update"]

  include passwords
  include service_cron_up
  include simple_puppet_client

}