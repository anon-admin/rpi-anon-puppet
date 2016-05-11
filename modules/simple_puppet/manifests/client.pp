class simple_puppet::client($manifest = $simple_puppet::manifest) inherits simple_puppet {

  contain simple_puppet::config
  contain simple_puppet::puppetadmin::definition
  contain simple_puppet::usrlocalbin::links

  contain simple_puppet::service::no
  contain conf::service::cron

  $run_puppet = "cd /etc/puppet/manifests && /usr/bin/puppet apply ${manifest}.pp"

  
  cron { "puppetclient_auto_run":
    command => "${run_puppet} > /var/log/puppet.log 2>&1",
    #ensure  => absent,
    user    => root,
    hour    => '13',
    minute  => '0',
    require => Service["cron"],
  }

}