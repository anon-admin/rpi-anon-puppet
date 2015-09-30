class puppet_clean inherits puppet_consts_ {

  $reports_dir = $puppet_consts_::reports_dir
  $clientbucket_dir = $puppet_consts_::clientbucket_dir

  tidy { ["${clientbucket_dir}", "${reports_dir}"]:
    recurse => true,
    backup  => false,
    age     => "1w",
    type    => 'mtime',
  }

  Tidy["${clientbucket_dir}"] {
    rmdirs  => false,
  }

  Tidy["${reports_dir}"] {
    rmdirs  => true,
  }


}

class puppet_usrlocalbin_links {

      file { ["/etc/puppet/scripts/uidmod.sh", "/etc/puppet/scripts/gidmod.sh"]:
        mode  => "a+x",
      }

      file { "/usr/local/bin/uidmod.sh":
        ensure => link,
        target => "/etc/puppet/scripts/uidmod.sh",
        before => Mount["/usr/local/bin"],
      }

      file { "/usr/local/bin/gidmod.sh":
        ensure => link,
        target => "/etc/puppet/scripts/gidmod.sh",
        before => Mount["/usr/local/bin"],
      }


      mount { "/usr/local/bin":
        atboot  => false,
        ensure  => absent,
      }
}

class simple_puppetadmin_definition_ inherits puppet_consts_ {

     $puppetadmin_user = $puppet_consts_::puppetadmin_user
     $puppetadmin_id = $puppet_consts_::puppetadmin_id
     $puppetadmin_shell = $puppet_consts_::puppetadmin_shell

     exec { "/usr/local/bin/uidmod.sh ${puppetadmin_id} ${puppetadmin_user}":
          require => Mount["/usr/local/bin"],
     }


  user { "${puppetadmin_user}":
    home    => "/etc/puppet",
    uid     => "${puppetadmin_id}",
    gid     => 'root',
    shell   => "${puppetadmin_shell}",
    require => Exec["/usr/local/bin/uidmod.sh ${puppetadmin_id} ${puppetadmin_user}"],
  }
  
  exec { "chown -R ${puppetadmin_user}:root /etc/puppet/":
    provider => shell,
    require  => User["${puppetadmin_user}"],
  }
  

}

class simple_puppet_package_ inherits package_wget_ {

  Package["wget"] {
    ensure => latest,
  }
  Package["wget"] -> Exec["/usr/bin/wget https://apt.puppetlabs.com/puppetlabs-release-${lsbdistcodename}.deb"]

  # monthly update
  cron { "force apt.puppetlabs update":
    command => "/usr/bin/dpkg -r puppetlabs-release ; /bin/rm /tmp/puppetlabs-release-${lsbdistcodename}.deb",
    #ensure  => absent,
    user    => root,
    special => 'monthly',
    require => Service["cron"],
  }

  exec { "/usr/bin/wget https://apt.puppetlabs.com/puppetlabs-release-${lsbdistcodename}.deb":
    cwd      => "/tmp",
    provider => shell,
    creates  => "/tmp/puppetlabs-release-${lsbdistcodename}.deb",
    before   => Exec["/usr/bin/dpkg -i puppetlabs-release-${lsbdistcodename}.deb"],
  }

  exec { "/usr/bin/dpkg -i puppetlabs-release-${lsbdistcodename}.deb":
    cwd      => "/tmp",
    provider => shell,
    unless   => "/usr/bin/dpkg --list puppetlabs-release",
    notify   => Exec["/usr/bin/apt-get update"],
  }

  package { ["puppet","facter"]:
    ensure => latest,
    require => Exec["/usr/bin/dpkg -i puppetlabs-release-${lsbdistcodename}.deb", "/usr/bin/apt-get update"],
  }
  
  package { "puppetmaster":
    ensure  => purged,
    require => Package["puppet"],
  }
  
  file { "/etc/puppet":
    ensure  => directory,
    require => Package["puppet"],
  }
  

}


class puppet_service_ {
  service { puppet:
  }

  file { "/etc/default/puppet":
    mode => 644,
    owner => root,
    group => root,
  }
}

class no_puppet_service inherits puppet_service_ {

  File["/etc/default/puppet"] {
    require => Package["puppet"],
    source => "/etc/puppet/files/puppet/no-auto-start",
  }
                 
  Service[puppet] {
    enable => false,
    ensure => stopped,
  }

}

class simple_puppet_client inherits puppet_consts_ {

  include simple_puppet_package_
  include simple_puppetadmin_definition_
  include puppet_usrlocalbin_links

  include no_puppet_service
  include service_cron_

  $manifest = $puppet_consts_::manifest

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