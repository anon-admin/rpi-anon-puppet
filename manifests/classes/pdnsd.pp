import "userids"

class pdnsd_package_ {
}

class pdnsd_ {
     user { "${pdnsd_user}":
     uid => "${pdnsd_id}",
     }

     file { "/var/cache/pdnsd":
        require => User["${pdnsd_user}"],
     }

     file { "/etc/pdnsd.conf":
        require => Package[pdnsd],
     }

     file { "/etc/default/pdnsd":
     }

     service { "pdnsd":
        require => File["/etc/pdnsd.conf", "/var/cache/pdnsd", "/etc/default/pdnsd"],
     }
}

class pdnsd inherits pdnsd_ {

     include tor

     exec { ["/usr/local/bin/uidmod.sh ${pdnsd_id} ${pdnsd_user}"]:
        require => [ Mount["/usr/local/bin"], Package[pdnsd] ],
     }


     exec { "/usr/sbin/service pdnsd stop":
           onlyif => ["/usr/sbin/service pdnsd status", "/usr/bin/test -z \"$( /bin/grep \'^${pdnsd_user}:x:${pdnsd_id}:\' /etc/passwd )\""],
     before  => User["${pdnsd_user}"],
     require => Package[pdnsd],
     }

     User["${pdnsd_user}"] {
     gid => "${squid_id}",
         ensure => present,
     require => [ Exec["/usr/local/bin/uidmod.sh ${pdnsd_id} ${pdnsd_user}", "/usr/sbin/service pdnsd stop"], Group["${squid_user}"] ],
     before  => [ Service["pdnsd"], Exec["do iptables"] ],
     }

     File["/var/cache/pdnsd"] {
    owner   => "${pdnsd_user}",
        mode    => "u+rw",
    recurse => true,
     } 

     File["/etc/default/pdnsd"] {
        source  => "file:///etc/puppet/modules/common/files/pdnsd.default",
     }

     File["/etc/pdnsd.conf"] {
        content => template("common/pdnsd.conf.erb"),
        notify  => Service["pdnsd"],
     }

     Service["pdnsd"] {
        ensure  => running,
        enable  => true,
    before  => Service[polipo,pritorxy],
     }
}


class pdnsd inherits userids {

     include pdnsd_package_

     $pdnsd_id = $userids::pdnsd_id
     $pdnsd_user = $userids::pdnsd_user
     $pdnsd_ip = $ip_eth0
     $pdnsd_port = 553
     
     
}