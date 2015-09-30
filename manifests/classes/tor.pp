import "userids"

class tor_package_ {

  file { "/etc/apt/sources.list.d/tor.list":
    owner  => root,
    before => Exec["/usr/bin/gpg --keyserver 213.133.103.71 --recv 886DDD89"],
  }

  exec { "/usr/bin/gpg --keyserver 213.133.103.71 --recv 886DDD89":
    cwd      => '/tmp',
    provider => shell,
    user     => root,
    before   => Exec["/usr/bin/gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | /usr/bin/apt-key add -"],
  }

  exec { "/usr/bin/gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | /usr/bin/apt-key add -":
    cwd      => '/tmp',
    provider => shell,
    user     => root,
    before   => Exec["/usr/bin/apt-get update"],
  }

  package { ["tor", "deb.torproject.org-keyring","tor-geoipdb"]:
  }


  File["/etc/apt/sources.list.d/tor.list"] {
    source => "/etc/puppet/files/tor/tor.sources.list",
  }
  Package["tor", "deb.torproject.org-keyring","tor-geoipdb"] {
    ensure  => latest,
    require => Exec["/usr/bin/apt-get update"],
  }

  case $architecture {
    'armv6l': {
      # Raspian in Pi1, repository does not work
      #
      # File["/etc/apt/sources.list.d/tor.list"] {
      #   ensure => absent,
      # }
      # Package["tor", "deb.torproject.org-keyring","tor-geoipdb"] {
      #   ensure  => absent,
      # }


      #-rwxr-xr-x root/root   ./usr/bin/tor-gencert
      #-rwxr-xr-x root/root   ./usr/bin/tor-resolve
      #-rwxr-xr-x root/root   ./usr/bin/tor
      #-rwxr-xr-x root/root   ./usr/bin/torify

      file { "/usr/local/share/tor":
        ensure => link,
	target => "/usr/share/tor",
      }
      file { "/usr/bin/tor":
        source  => "/var/tor/stable/src/or/tor",
	notify  => Service["tor"],
      }
      file { "/usr/bin/torify":
        source  => "/var/tor/stable/contrib/client-tools/torify",
      }
      file { "/usr/bin/tor-gencert":
        source  => "/var/tor/stable/src/tools/tor-gencert",
      }
      file { "/usr/bin/tor-resolve":
        source  => "/var/tor/stable/src/tools/tor-resolve",
      }
      File["/usr/local/share/tor", "/usr/bin/tor", "/usr/bin/torify", "/usr/bin/tor-gencert", "/usr/bin/tor-resolve"] {
        require => Package["tor"],
        before  => Service["tor"],
	owner   => root,
        group   => root,
        mode    => 755,
      }

    }
  }

}

class tor inherits userids {

     include tor_package_

     $tor_id = $userids::tor_id
     $tor_user = $userids::tor_user


     exec { ["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}","/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"]:
     	  require => [ Mount["/usr/local/bin"], Package[tor] ],
     }

     file { ["/var/tor/etc", "/var/tor/log","/var/tor/lib"]: 
           ensure  => directory,
	   before  => Mount["/etc/tor", "/var/log/tor","/var/lib/tor"],
     }

     file { ["/etc/tor","/var/log/tor","/var/lib/tor"] :
     	   ensure => directory,
	   mode   => "g+rw",
	   before => Group["${tor_user}"],
     }
     exec { "/usr/bin/find /var/log/tor -name '*~' -delete":
     	  onlyif  => "/usr/bin/test -d /var/log/tor",
     }

     File ["/var/log/tor"] {
          require => Exec["/usr/bin/find /var/log/tor -name '*~' -delete"],
	  recurse => true,
     }


     mount { "/etc/tor":
     	   device => "/var/tor/etc",
           require => File["/var/tor/etc","/etc/tor"], 
     }
     mount { "/var/log/tor":
     	   device => "/var/tor/log",
           require => File["/var/tor/log","/var/log/tor"], 
    }
     mount { "/var/lib/tor":
     	   device => "/var/tor/lib",
           require => File["/var/tor/lib","/var/lib/tor"], 
     }

     exec { ["/bin/chown -R :${tor_user} /etc/tor","/bin/chown -R :${tor_user} /var/log/tor","/bin/chown -R :${tor_user} /var/lib/tor"]:
	   require => [ Mount["/etc/tor","/var/log/tor","/var/lib/tor"], Package["tor"] ],
	   before  => Service[tor],
	   notify  => Service[tor],
     }

     Mount["/etc/tor","/var/log/tor","/var/lib/tor"] {
     	   fstype  => none,
	   options => bind,
           before  => Package[tor],
     	   atboot  => true,
	   ensure  => mounted,
	   notify  => Service[tor],
     }

     exec { "/usr/sbin/service tor stop":
           onlyif => ["/usr/sbin/service tor status", "/usr/bin/test -z \"$( /bin/grep \'^${tor_user}:x:${tor_id}:\' /etc/passwd )\""],
	   before  => User["${tor_user}"],
	   require => Package[tor],
	   notify  => Service[tor],
     }

     group { "${tor_user}":
     	   ensure => present,
	   gid => "${tor_id}",
     }
     Exec["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}"] -> Group["${tor_user}"]

     user { "${tor_user}":
     	   ensure  => present,
	   uid     => "${tor_id}",
	   gid     => "${tor_user}",
	   before  => Service["tor"], 
	   notify  => Service[tor],
     }
     Exec["/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"] -> User["${tor_user}"]
     Group["${tor_user}"] -> User["${tor_user}"]

     file { "/etc/default/tor":
     	  source  => "/etc/puppet/files/tor/tor.default",
     }

     $hostname_array = split( $hostname , "_" )
     $real_hostname = $hostname_array[0]

     file { "/etc/tor/torrc" :
     	  content => template("tor/torrc.erb"),
     }

     file { "/var/lib/tor/.torrc":
       ensure  => link,
       target  => "/etc/tor/torrc",
       require => Mount["/var/lib/tor"],
       before  => Service["tor"],
     }

     File["/etc/default/tor","/etc/tor/torrc"] {
	  require => [ Mount["/etc/tor"], Package[tor] ],
	  before  => Service["tor"],
	  notify  => Service["tor"],
     }

     exec { "sticky on /var/log/tor":
     	  command    => "/bin/chmod g+s /var/log/tor",
     	  require => Mount["/var/log/tor"],
     }

     service { "tor":
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/default/tor", "/etc/tor/torrc"],
	  	       Exec["sticky on /var/log/tor"],
	  	       User["${tor_user}"] ],
     }
}
