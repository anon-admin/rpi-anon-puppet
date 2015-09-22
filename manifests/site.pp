node default {

     # a mettre dans iptables et dans dnsmasq.conf
     $xenahd_ip = "192.168.0.13"
     $xenahd_mac = "00:1c:5e:00:5a:51"

     $boxap_ssid = "AndroidAP4481"
     $boxap_psk = "1234567890"
     $wlan0_ip = $ipaddress_wlan0

     $main_repository = "mirrordirector.raspbian.org" 
     $bind9_dnssec_validation = "no"
     $repositories = [ "${main_repository}" , "archive.raspberrypi.org", "ftp4.igh.cnrs.fr" ]
     $securedrepositories = [ "192.30.252.129", "185.31.17.133", "185.31.18.133", "ip1a-lb3-prd.iad.github.com", "ip1b-lb3-prd.iad.github.com", "ip1c-lb3-prd.iad.github.com", "ip1d-lb3-prd.iad.github.com", "raw.github.com" ]

     $apt_cacher_ng_ip="10.4.0.1"
     $apt_cacher_ng_volname="aptcacher_cache"

     $vpn_network = "10.4.0.0/22"
     $vpn_port = 1194

     $dyndns_domain = "dyndns-at-home.com"

     case $macaddress_eth0 {
     "b8:27:eb:ae:12:1d": { 
        $start_cron = "0"
        $stop_cron = "22"
     	$hostn = "palette" 
	$domainn = "ppprod.biz"
	$other_domainn = "ppprod2.biz"
	$arpa_domainn = "192.168.2"
	$other_arpa_domainn = "192.168.3"
	$invers_arpa_domainn = "2.168.192"
	$other_invers_arpa_domainn = "3.168.192"
        $eth0_ip = "192.168.2.1"
	$tor_nickname = "6cfdb97abb21"
	$site = "stm"
	$vpn_ip = "10.4.0.2"
	$vpn_other = "10.4.0.1"
	$vpn_other_host_fqdn = "experience.vpn"
	$vpn_other_host = "experience"
	$nameservers = [ "192.168.1.1" ]
	$wl_ppprod_wan_mac="00:09:5b:c3:a8:1f"
	$wl_ppprod_hname="WGT624"
	$wl_ppprod_lan_mac="00:09:5B:C3:A8:1E"
	}
     "b8:27:eb:ac:9f:fc": { 
        $start_cron = "1"
        $stop_cron = "23"
     	$hostn = "experience" 
	$domainn = "ppprod2.biz"
	$other_domainn = "ppprod.biz"
	$arpa_domainn = "192.168.3"
	$other_arpa_domainn = "192.168.2"
	$invers_arpa_domainn = "3.168.192"
	$other_invers_arpa_domainn = "2.168.192"
        $eth0_ip = "192.168.3.1"
	$tor_nickname = "6cfdb97abb9a"
	$site = "tln"
	$vpn_ip = "10.4.0.1"
	$vpn_other = "10.4.0.2"
	$vpn_other_host_fqdn = "palette.vpn"
	$vpn_other_host = "palette"
	$nameservers = [ "212.27.40.240", "212.27.40.241" ]
	$wl_ppprod_wan_mac="00:0f:b5:e1:78:9b"
	$wl_ppprod_hname="WGR614v5"
	$wl_ppprod_lan_mac="00:09:5B:C3:A8:1E"
	}
     }

     $masqued_machines = [ "65","66","67" ]
     $masqued_macs = {
         65 => { 'mac' => '6c:fd:b9:7f:97:9b', 'hostname' => '' },
         66 => { 'mac' => '00:40:d0:78:d8:ca', 'hostname' => 'reac' },
         67 => { 'mac' => '00:a0:d1:34:ce:ca', 'hostname' => 'presentation' },
     }

     $anonymous_id = 1000
     $anonymous_user = "anonymous"

     $squid_id = 13
     $squid_user = "proxy"
     $squid_ip = "127.0.0.1"
     $squid_port = 3128


     $pdnsd_id = 108
     $pdnsd_user = pdnsd
     $pdnsd_ip = "${arpa_domainn}.253"
     $pdnsd_port = 53

     $polipo_ip = "127.0.0.1"
     $polipo_port = 8123


     $privoxy_id = 109
     $privoxy_user = privoxy
     $privoxy_port = 8118
     	  
     $dnsmasq_id = 110
     $dnsmasq_user = "dnsmasq"

     $dnsproxy_id = 111
     $dnsproxy_user = dnsproxy

     $acng_id = 112
     $acng_user = "apt-cacher-ng"

     $bind_id = 116
     $bind_user = bind

     $tor_id = 117
     $tor_user = "debian-tor"
     $tor_interf = "lo"
     $tor_ip = "127.0.0.1"
     $tor_port = 9050
     $tor_external_port = 9090
     $tor_external_public_port = 443
     $tor_oignon_pages_ip = "10.192.0.0/10"
     $tor_oignon_pages_port = 9040
     $tor_dns_port = 5353

     $watchdog_id = 118
     $watchdog_user = watchdog

     $pritorxy_id = 119
     $pritorxy_user = pritorxy
     $pritorxy_ip = "${pdnsd_ip}"
     $pritorxy_port = 8118

     $i2p_id = 122
     $i2p_user = "i2p"
     $i2p_home = "/var/lib/i2p"
     $i2p_version = "0.9.9"
     $i2p_service = "i2prouter"
     $i2p_confdir = "${i2p_home}/.i2p"
     $i2p_pidfile = "${i2p_confdir}/router.pid"
     $i2p_ip = "127.0.0.1"
     $i2p_webconsole_port = 7657
     $i2p_httpproxy_port = 4444
     $i2p_httpsproxy_port = 4445

     mount { "/var/log":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "/dev/mapper/system-varlog",
	  fstype  => ext2,
	  options => "rw,relatime,sync",
     }

     # service { "reboot":
     # 	  ensure     => running,
     #    hasrestart => false,
     #    start      => "/bin/true",
     #    hasstatus  => false,
     #    status     => "/bin/true",
     #    require    => Service["monit"],
     # }

     exec { "hostname ${hostn}":
          command => "/bin/hostname ${hostn}",
     }

     Mount["/var/log"] -> Package<| |>
     Exec["hostname ${hostn}"] -> Package<| |>

     
     file { "/etc/hostname":
     	  content => $hostn,
	  require => Exec["hostname ${hostn}"],
     }

     host { localhost:
     	  ensure => present,
	  ip => "127.0.0.1",
	  host_aliases => $hostn,
	  require => File["/etc/hostname"],
     }

     host { "${vpn_other_host_fqdn}":
     	  ensure => present,
	  ip => "${vpn_other}",
	  host_aliases => "${vpn_other_host}",
	  require => File["/etc/hostname"],
     }

     Host<| |> -> Package<| |>

     cron { "puppet apply":
     	  command => "mount | grep ':[/]*puppet_rpi on /etc/puppet type fuse.glusterfs (rw,' 1>/dev/null || mount /etc/puppet ; cd /etc/puppet && find . -name '*~' -delete ; /usr/bin/puppet apply /etc/puppet/manifests/site.pp",
	  user    => root,
	  hour    => "${start_cron}-${stop_cron}/2",
	  minute  => 0,
	  require => Mount["/etc/puppet"],
     }

     cron { "apt-get update":
     	  command => "/usr/bin/apt-get update && apt-get -y upgrade && apt-get -y autoremove ; apt-get -y upgrade && apt-get -py dist-upgrade ; apt-get -y upgrade || apt-get -yf install",
	  user    => root,
	  hour    => "${start_cron}",
	  minute  => 15,	  
	  weekday => 1,
     }

     $compute_size = "SIZ=\$( df -h /var/log | tail -1 | tr -s \' \' \' \' | cut -f5 -d\' \' | cut -f1 -d\'%\' )"
     $clean_archives = "test \${SIZ} -gt 80 && find /var/log -name \'*.gz\' -delete"
     $compute_file = "FILE=\$( ( for f in \$( find /var/log/ -type f ) ; do du \$f ; done ) | sort -n | tail -1 | tr -s \'\\t \' \'  \' | cut -f2 -d\' \' )"
     $clean_file = "test -f \"\$FILE\" -a \$SIZ -gt 90 && echo >\$FILE"

     $emergency = "${compute_size} ; ${clean_archives} ; ${compute_file} ; ${clean_file}"

     cron { "emergency log cleaning":
     	  command => "${emergency}",
	  user    => root,
	  hour    => '*/2',
	  minute  => 0,	  
     }

     # exec { "/usr/bin/wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update":
     # 	  creates => "/usr/bin/rpi-update",
     # 	  require => Package[git-core,ca-certificates],
     # }

     # file { "/usr/bin/rpi-update":
     # 	  mode    => "+x",
     # 	  require => Exec["/usr/bin/wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O /usr/bin/rpi-update"],
     # }
     	  
     service { "dphys-swapfile":
     	  ensure  => stopped,
	  enable  => false,
	  before  => Exec["/sbin/dphys-swapfile swapoff"],
     }

     exec { "/sbin/dphys-swapfile swapoff":
     }

     cron { "apt-get full update":
     	  command => '/usr/sbin/service apt-cacher-ng restart && apt-get update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y dist-upgrade && ( PUPPET_PID=$(pgrep puppet) ; test -n "${PUPPET_PID}" && kill -9 ${PUPPET_PID} ; for SRV in monit tor i2prouter ; do service $SRV stop ; done ; rpi-update && sleep 10 && reboot )',
	  user    => root,
	  hour    => "${start_cron}",
	  minute  => 30,	  
	  monthday => 1,
	  require  => Package[git-core, ca-certificates, rpi-update],
     }

     exec { "openvpn between rpi":
     	  command => "/bin/bash -c 'test -f /var/run/openvpn.vpn_rpi.pid -a -n \"$( ps -e | grep openvpn | grep $( cat /var/run/openvpn.vpn_rpi.pid ) )\" || /data/glusterfs/.local/scripts/vpn_rpi start'",
     }


     include nfscommon

     package { [glusterfs-server,glusterfs-client, monit, git-svn, git-core, ca-certificates, rpi-update]:
     	  ensure => latest,
     }

     Package[glusterfs-server,glusterfs-client] {
     	  require => Package[nfs-common],
     }


     service { "glusterfs-server":
     	  ensure  => running,
	  enable  => true,
	  require => [ Package[glusterfs-server,glusterfs-client, rpcbind], 
	  	       Exec["openvpn between rpi"],
		       Service["nfs-common"] ],
	  before  => Service["monit"],
     }     

     mount { "/var/lib/puppet/clientbucket":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "/dev/mapper/system-puppet_bucket",
	  fstype  => ext4,
	  options => "defaults",
	  before  => [ Mount["/etc/puppet"], Tidy["/var/lib/puppet/clientbucket"] ],
     }


     tidy { ["/var/lib/puppet/clientbucket","/var/lib/puppet/reports","/tidy/var/lib/puppet/clientbucket"]:
	  backup  => false,
     }

     Tidy["/var/lib/puppet/clientbucket","/var/lib/puppet/reports"] {
	  before  => Mount["/etc/puppet"],
	  recurse => true,
          age     => '8w',
     }

     Tidy["/var/lib/puppet/clientbucket"] {
     	  require => Mount["/var/lib/puppet/clientbucket"],
	  rmdirs  => false,
     }

     Tidy["/var/lib/puppet/reports"] {
	  rmdirs  => true,
     }

     mount { "/etc/puppet":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "${vpn_ip}:puppet_rpi",
	  fstype  => glusterfs,
	  options => "rw,noauto",
	  require => Service["glusterfs-server"], 
	  before  => Service["monit"],
     }

     mount { "/usr/local/bin":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "/etc/puppet/scripts",
	  fstype  => "none",
	  options => "bind,noauto",
	  require => Mount["/etc/puppet"], 
	  before  => Service["monit"],
     }

     file { "/etc/puppet/scripts/vpn.rpi.${site}.monit":
     	  content => template("scripts/vpn.rpi.monit.erb"),
	  require => Mount["/etc/puppet"]
     }

     exec { "/usr/bin/find /etc/monit/conf.d -name '*~' -delete":
     }

     file { "/etc/monit/conf.d/vpn.rpi.monit":
     	  ensure  => "/data/glusterfs/.local/scripts/vpn.rpi.${site}.monit",
	  require => [ Package[monit], File["/etc/puppet/scripts/vpn.rpi.${site}.monit"],
	  	       Exec["/usr/bin/find /etc/monit/conf.d -name '*~' -delete"] ],
	  notify  => Service["monit"],
     }

     file { "/etc/monit/monitrc":
     	  source  => "file:///etc/puppet/modules/common/files/monitrc",
	  mode => 0600,
     	  require => [ Package[monit], File["/etc/monit/conf.d/vpn.rpi.monit"] ],
	  notify  => Service["monit"],
     }

     service { "monit":
     	  ensure  => running,
	  enable  => true,
	  require => [ Package[monit], File["/etc/puppet/scripts/vpn.rpi.${site}.monit" ] ],
     }     

     file { "/etc/rc.local":
     	  source  => "file:///etc/puppet/modules/common/files/rc.local",
	  mode => 0755,
     }

     file { "/etc/network/interfaces":
     	  content => template("network/interfaces.erb"),     
     }
     # notify => Service[reboot],

     file { "/tidy":
          ensure => directory,
     }

     mount { "/tidy":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "/",
	  fstype  => "none",
	  options => "bind,auto",
	  require => File["/tidy"],
     }

     tidy { ["/var/log", "/tidy/var/log","/tidy/etc/puppet","/var/cache/apt/archives/"]:
          age     => "4w",
	  recurse => true,
     }

     Tidy["/tidy/var/lib/puppet/clientbucket"] {
          age     => "4w",
	  recurse => true,
     }

     Tidy["/tidy/var/log","/tidy/etc/puppet","/tidy/var/lib/puppet/clientbucket"] {
	  rmdirs  => true,
	  require => Mount["/tidy"],
     }

     Tidy["/var/log"] {
	  rmdirs  => true,
	  require => Mount["/var/log"],
     }

     Tidy["/var/log"] -> Package<| |>
     Package<| |> -> Tidy["/var/cache/apt/archives/"]     

     exec { "/usr/bin/find /tidy/etc/default -name '*~' -delete":
          require => Mount["/tidy"],
     }

     
     exec { ["/usr/local/bin/gidmod.sh ${watchdog_id} ${watchdog_user}","/usr/local/bin/uidmod.sh ${watchdog_id} ${watchdog_user}"]:
     	  require => Mount["/usr/local/bin"], 
     }

     group { "${watchdog_user}":
     	   ensure => present,
	   gid => "${watchdog_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${watchdog_id} ${watchdog_user}"],
     }


     exec { "/usr/sbin/service pingwatchdog stop":
           onlyif => ["/usr/sbin/service pingwatchdog status", "/usr/bin/test -z \"$( /bin/grep \'^${watchdog_user}:x:${watchdog_id}:\' /etc/passwd )\""],
	   before  => User["${watchdog_user}"],
     }

     user { "${watchdog_user}":
     	   ensure => present,
	   uid    => "${watchdog_id}",
	   gid    => "${watchdog_user}",
	   home   => "/tmp",
	   shell  => "/bin/false",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${watchdog_id} ${watchdog_user}"], Group["${watchdog_user}"] ],
	   before  => Service["pingwatchdog"],
     }

     file { "/bin/pingwatchdog":
     	  mode    => "a+x",
     	  content => template("scripts/pingwatchdog.erb"),
	  before  => File["/etc/init.d/pingwatchdog"],
     }

     file { "/etc/init.d/pingwatchdog":
     	  owner   => root,
     	  mode    => "u+rwx",
     	  content => template("scripts/pingwatchdog.service.erb"),
	  before  => Service["pingwatchdog"],
     }

     file { "/etc/pingwatchdog.conf":
     	  content => template("scripts/pingwatchdog.conf.erb"),
	  before  => Service["pingwatchdog"],
     }

     service { "pingwatchdog":
     	  ensure  => running,
	  enable  => true,
     }

     file { "/usr/lib/ruby/vendor_ruby/facter/public_ip.rb": 
     	  source  => "file:///etc/puppet/modules/network/files/public_ip.rb",
     }

     cron { [ "fullfill /etc/public_ip hourly", "fullfill /etc/public_ip at reboot" ]:
	  command => "/bin/bash -c \"/usr/bin/dig ${hostn}.${dyndns_domain} | /bin/grep \'^${hostn}.${dyndns_domain}.\\s\' | /usr/bin/tr -s ' \\t' '  ' | /usr/bin/cut -f5 -d' ' | /usr/bin/head -1 >/etc/public_ip \"",
     }
     
     Cron["fullfill /etc/public_ip hourly"] {
     	  special => 'hourly',
     }
     
     Cron["fullfill /etc/public_ip at reboot"] {
     	  special => 'reboot',
     }

}


class dnsproxy_ {
     group { "${dnsproxy_user}":
	   gid => "${dnsproxy_id}",
     }

     user { "${dnsproxy_user}":
	   uid => "${dnsproxy_id}",
     }

     file { "/etc/dnsproxy.conf":
     	  require => Package[dnsproxy],
     }

     file { "/etc/rsyslog.d/dnsproxy.conf":
	  notify  => Service["rsyslog"],
	  require => Package["rsyslog"],
     }     

     service { "dnsproxy":
     	  require => File["/etc/dnsproxy.conf"],
     }
}

class dnsproxy inherits dnsproxy_ {
     exec { ["/usr/local/bin/uidmod.sh ${dnsproxy_id} ${dnsproxy_user}","/usr/local/bin/gidmod.sh ${dnsproxy_id} ${dnsproxy_user}"]:
     	  require => [ Mount["/usr/local/bin"], Package[dnsproxy] ],
     }

     Group["${dnsproxy_user}"] {
     	   ensure => present,
	   require => Exec["/usr/local/bin/gidmod.sh ${dnsproxy_id} ${dnsproxy_user}"],
     }


     exec { "/usr/sbin/service dnsproxy stop":
           onlyif => ["/usr/sbin/service dnsproxy status", "/usr/bin/test -z \"$( /bin/grep \'^${dnsproxy_user}:x:${dnsproxy_id}:\' /etc/passwd )\""],
	   before  => User["${dnsproxy_user}"],
	   require => Package[dnsproxy],
     }

     user { "${dnsproxy_user}":
	   gid => "${dnsproxy_id}",
     	   ensure => present,
	   require => [ Exec["/usr/local/bin/uidmod.sh ${dnsproxy_id} ${dnsproxy_user}", "/usr/sbin/service dnsproxy stop"], Group["${dnsproxy_user}"] ],
 	   before  => [ Service["dnsproxy"], Exec["do iptables"] ],
     }

     File["/etc/dnsproxy.conf"] {
     	  source  => "file:///etc/puppet/modules/common/files/dnsproxy.conf",
     	  notify  => Service["dnsproxy"],
     }

     File["/etc/rsyslog.d/dnsproxy.conf"] {
     	  source  => "file:///etc/puppet/modules/common/files/rsyslog.dnsproxy.conf",
     	  before  => Service["dnsproxy"],
     }     

     Service["dnsproxy"] {
     	  ensure  => running,
     	  enable  => true,
     }
}

class no_dnsproxy inherits dnsproxy_ {
     Group["${dnsproxy_user}"] {
     	   ensure => absent,
     }

     User["${dnsproxy_user}"] {
     	   ensure => absent,
     }


     File["/etc/dnsproxy.conf"] {
	  ensure  => absent,
     }

     File["/etc/rsyslog.d/dnsproxy.conf"] {
          ensure  => absent,
     }     

     Service["dnsproxy"] {
     	  enable  => false,
     }

}

class rpcbind_ {
     package { rpcbind:
     }

     file { ["/etc/default/rpcbind", "/etc/rpcbind.conf"]:
     	  ensure => absent,
     }

     service { "rpcbind":
     }
}

class no_rpcbind inherits rpcbind_ {
}

class rpcbind inherits rpcbind_ {
     Package[rpcbind] {
     	  ensure => latest,
     }

     File["/etc/default/rpcbind", "/etc/rpcbind.conf"] {
     	  notify => Service["rpcbind"],
     }

     Service["rpcbind"] {
     	  ensure  => running,
	  enable  => true,
          require => Package[rpcbind],
     }

}


class nfscommon_ {
     package { nfs-common:
     }

     file { "/etc/exports":
     }

     service { "nfs-common":
     }
}

class no_nfscommon inherits nfscommon_ {
     Package[nfs-common] {
          ensure  => purged,
          before  => Package[rpcbind],
     }

     File["/etc/exports"] {
          ensure => absent,
     }

     Service["nfs-common"] {
	  enable  => false,
     }
}

class nfscommon inherits nfscommon_ {

     include rpcbind

     Package[nfs-common] {
          ensure  => latest,
          require => Package[rpcbind],
     }

     File["/etc/exports"] {
     	  content => template("common/nfs.exports.erb"),
	  before  => Service["nfs-common"],
	  notify  => Service["nfs-common"],
          require => Package[nfs-common],
     }

     Service["nfs-common"] {
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/exports"],
	  	       Service["rpcbind"] ],
     }

}

class i2p {

     file { "/data/glusterfs/.i2p":
     	  ensure => directory,
     }

     mount { "/data/glusterfs/.i2p":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "/dev/mapper/system-i2p.glfs.rpi",
	  fstype  => ext4,
	  options => "rw,auto",
	  before  => Service["glusterfs-server"],
	  require => File["/data/glusterfs/.i2p"],
     }

     exec { "/usr/local/bin/uidmod.sh ${i2p_id} ${i2p_user}":
     	  require => Mount["/usr/local/bin"],
     }

     exec { "/usr/sbin/service ${i2p_service} stop":
           onlyif => ["/usr/sbin/service ${i2p_service} status", "/usr/bin/test -z \"$( /bin/grep \'^${i2p_user}:x:${i2p_id}:\' /etc/passwd )\""],
	   before  => User["${i2p_user}"],
     }

     exec { "${i2p_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${i2p_user}:x:${i2p_id}:\' /etc/passwd )\"",
	   before  => User["${i2p_user}"],
     }

     exec { "${i2p_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${i2p_user}:x:${i2p_id}:\' /etc/passwd )\"",
	   before  => User["${i2p_user}"],
     }

     user { "${i2p_user}":
     	   ensure => present,
	   uid => "${i2p_id}",
	   gid => 65534,
	   home => "${i2p_home}",
	   require => Exec["/usr/local/bin/uidmod.sh ${i2p_id} ${i2p_user}"],
	   before  => [ Service["${i2p_service}"], Exec["do iptables"] ],
     }

     exec { "/bin/chown ${i2p_user} /data/glusterfs/.i2p":
     	  require => [ Mount["/data/glusterfs/.i2p"], User["${i2p_user}"] ],
	  before  => File["${i2p_home}"],
     }

     exec { "/bin/mkdir -p ${i2p_home}":
          onlyif => "/usr/bin/test ! -d ${i2p_home}",
     }

     mount { "${i2p_home}":
     	   device  => "LABEL=DATA-i2p",
	   fstype  => ext4,
	   options => "defaults",
	   pass    => 2,
     	   atboot  => true,
	   ensure  => mounted,
           require => Exec["/bin/mkdir -p ${i2p_home}"],
	   before  => File["${i2p_home}", "${i2p_home}/versions", "${i2p_confdir}", "${i2p_confdir}/eepsite", "${i2p_confdir}/eepsite/docroot", "${i2p_confdir}/eepsite/logs"],
     }

     file { [ "${i2p_home}", "${i2p_home}/versions", "${i2p_confdir}", "${i2p_confdir}/eepsite", "${i2p_confdir}/eepsite/docroot", "${i2p_confdir}/eepsite/logs" ]:
     	  ensure  => directory,
	  owner   => "${i2p_user}",
          require => User["${i2p_user}"],
     }

     file { "${i2p_confdir}/hosts.txt":
          ensure  => file,
	  owner   => "${i2p_user}",
	  mode    => "u+rw",
     	  source  => "file://${i2p_home}/${i2p_version}/hosts.txt",
          replace => false,
	  require => [ File["${i2p_home}/${i2p_version}"], User["${i2p_user}"] ],
     }

     File["${i2p_confdir}"] {
     	  recurse => true,
	  mode    => "u+rw",
     }

     mount { "${i2p_home}/versions":
     	  atboot  => true,
	  ensure  => mounted,
	  device  => "${vpn_ip}:i2p_rpi",
	  fstype  => glusterfs,
	  options => "rw,noauto",
	  require => [ Service["glusterfs-server"], File["${i2p_home}/versions"], Mount["${i2p_home}"] ],
	  before  => [ Service["monit"], Service["${i2p_service}"] ],
     }

     file { "${i2p_confdir}/clients.config":
     	  ensure  => file,
     	  content => template("common/${i2p_version}/i2p.clients.config.erb"),
	  notify  => Service["${i2p_service}"],
     }

     file { "${i2p_confdir}/wrapper.config":
     	  ensure  => file,
     	  content => template("common/${i2p_version}/i2p.wrapper.config.erb"),
	  notify  => Service["${i2p_service}"],
     }

     file { "${i2p_confdir}/i2ptunnel.config":
     	  ensure  => file,
     	  content => template("common/${i2p_version}/i2p.i2ptunnel.config.erb"),
	  notify  => Service["${i2p_service}"],
     }

#     file { "${i2p_confdir}/router.config":
#     	  ensure  => file,
#     	  content => template("common/${i2p_version}/i2p.router.config.erb"),
#	  notify  => Service["${i2p_service}"],
#     }

     file { "${i2p_confdir}/logger.config":
     	  ensure  => file,
     	  content => template("common/${i2p_version}/i2p.logger.config.erb"),
	  notify  => Service["${i2p_service}"],
     }

     file { "${i2p_home}/${i2p_version}":
     	  ensure  => "${i2p_home}/versions/${i2p_version}",
	  require => Mount["${i2p_home}/versions"],
     }

     file { "${i2p_home}/logs":
     	  ensure => directory,
     	  owner   => "${i2p_user}",
     }

     file { "/tidy${i2p_home}/logs":
     	  ensure  => directory,
     	  owner   => "${i2p_user}",
     	  mode    => "u-rw",
	  require => [ Mount["/tidy"], File["${i2p_home}/logs"] ],
     }

     exec { "/usr/bin/find /tidy${i2p_home}/logs -type f -delete":
          require => File["/tidy${i2p_home}/logs"],
     }

     file { ["${i2p_home}/${i2p_version}/logs", "${i2p_confdir}/logs"]:
     	  ensure  => "${i2p_home}/logs",
	  force   => true,
	  require => [ File["${i2p_home}/${i2p_version}"], Mount["${i2p_home}/logs"] ],
	  before  => Service["${i2p_service}"],
     }


     file { ["/var/log/i2p", "/var/log/i2p/eepsite"]:
     	  ensure  => directory,
     	  owner   => "${i2p_user}",
     	  mode    => "u+rwx",
	  require => [ Mount["/var/log"], User["${i2p_user}"] ],
     }

     mount { "${i2p_home}/logs":
     	   fstype  => none,
	   options => "bind",
	   device  => "/var/log/i2p",
           before  => [ Tidy["/tidy/var/log"], Mount["/tidy"] ],
     	   atboot  => true,
	   ensure  => mounted,
	   require => [File["/var/log/i2p", "${i2p_home}/logs"], Mount["${i2p_home}"]],
     }

     mount { "${i2p_confdir}/eepsite/logs":
     	   fstype  => none,
	   options => "bind",
	   device  => "/var/log/i2p/eepsite",
           before  => [ Tidy["/tidy/var/log"], Mount["/tidy"] ],
     	   atboot  => true,
	   ensure  => mounted,
	   require => [ File["/var/log/i2p/eepsite", "${i2p_home}/logs"], Mount["${i2p_home}"]],
     }


     file { "${i2p_home}/runplain.sh":
     	  owner   => i2p,
     	  mode    => "u+rwx",
     	  content => template("scripts/${i2p_version}/i2p.runplain.sh.erb"),
     }

     file { "/etc/init.d/${i2p_service}":
     	  owner   => root,
     	  mode    => "u+rwx",
     	  content => template("scripts/${i2p_version}/i2p.service.erb"),
	  require => File["${i2p_home}/runplain.sh"], 
	  before  => Service["${i2p_service}"],
     }

     service { "${i2p_service}": 
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["${i2p_home}/${i2p_version}", "${i2p_confdir}"],
                       Mount["${i2p_home}/logs"],
	  	       Exec["do iptables"],
	  	       User["${i2p_user}"],
		       Service["squid3"] ],
     }

     file { "/etc/monit/conf.d/i2p.monit":
     	  content => template("common/i2p.monit.erb"),
	  require => Service["${i2p_service}"],
	  notify => Service["monit"],
     }


}

class tor {
     exec { ["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}","/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"]:
     	  require => [ Mount["/usr/local/bin"], Package[tor] ],
     }

     file { "/var/tor":
	   ensure => directory,
     }
     mount { "/var/tor":
     	   device  => "LABEL=DATA-tor",
	   fstype  => ext4,
	   options => "defaults",
	   pass    => 2,
     	   atboot  => true,
	   ensure  => mounted,
           require => File["/var/tor"],
     }

     file { ["/var/tor/etc", "/var/tor/log","/var/tor/lib"]: 
           ensure  => directory,
	   require => Mount["/var/log"],
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
          require => [ Mount["/var/log"], Exec["/usr/bin/find /var/log/tor -name '*~' -delete"] ],
	  recurse => true,
     }


     mount { "/etc/tor":
     	   device => "/var/tor/etc",
           require => [ File["/var/tor/etc","/etc/tor"], 
		   Mount["/var/tor"] ],
     }
     mount { "/var/log/tor":
     	   device => "/var/tor/log",
           require => [ File["/var/tor/log","/var/log/tor"], 
		   Mount["/var/tor"] ], 
    }
     mount { "/var/lib/tor":
     	   device => "/var/tor/lib",
           require => [ File["/var/tor/lib","/var/lib/tor"], 
		   Mount["/var/tor"] ],
     }

     exec { ["/bin/chown -R :${tor_user} /etc/tor","/bin/chown -R :${tor_user} /var/log/tor","/bin/chown -R :${tor_user} /var/lib/tor"]:
	   require => [ Mount["/etc/tor","/var/log/tor","/var/lib/tor"], Package["tor"] ],
	   before  => Service[tor],
     }

     Mount["/etc/tor","/var/log/tor","/var/lib/tor"] {
     	   fstype  => none,
	   options => bind,
           before  => Package[tor],
     	   atboot  => true,
	   ensure  => mounted,
     }

     exec { "/usr/sbin/service tor stop":
           onlyif => ["/usr/sbin/service tor status", "/usr/bin/test -z \"$( /bin/grep \'^${tor_user}:x:${tor_id}:\' /etc/passwd )\""],
	   before  => User["${tor_user}"],
	   require => Package[tor],
     }

     exec { "${tor_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${tor_user}:x:${tor_id}:\' /etc/passwd )\"",
	   before  => User["${tor_user}"],
	   require => Package[tor],
     }

     exec { "${tor_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${tor_user}:x:${tor_id}:\' /etc/passwd )\"",
	   before  => User["${tor_user}"],
	   require => Package[tor],
     }

     group { "${tor_user}":
     	   ensure => present,
	   gid => "${tor_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}"],
     }

     user { "${tor_user}":
     	   ensure => present,
	   uid => "${tor_id}",
	   gid => "${tor_user}",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"], Group["${tor_user}"] ],
	   before  => [ Service["tor"], Exec["do iptables"] ],
     }

     file { "/etc/default/tor":
     	  source  => "file:///etc/puppet/modules/common/files/tor.default",
     }

     file { "/etc/tor/torrc" :
     	  content => template("common/torrc.erb"),
     }

     File["/etc/default/tor","/etc/tor/torrc"] {
	  require => [ Mount["/etc/tor"], Package[tor], Service["squid3"] ],
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
	  	       Exec["do iptables", "sticky on /var/log/tor"],
	  	       User["${tor_user}"] ],
          before  => Service["pdnsd", polipo],
     }
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

class polipo {

     include tor
     include pdnsd

     exec { "/usr/bin/find /etc/polipo -name '*~' -delete":
     	  require => Package[polipo],
     }

     file { "/etc/polipo":
	  group   => "${squid_user}",
     	  require => [ Group["${squid_user}"], Exec["/usr/bin/find /etc/polipo -name '*~' -delete"] ],
     	  mode    => "g+r",
	  recurse => true,
     }

     file { "/etc/polipo/config": 
     	  content => template("common/polipo.config.erb"),
	  require => File["/etc/polipo"],
     }

     service { "polipo":
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/polipo/config"],
	  	       Service["tor"],
	  	       User["${squid_user}"], Group["${squid_user}"] ],
     }

}

class pritorxy {

     include polipo
     include pdnsd

     file { "/etc/pritorxy/":
          ensure => directory,
     }
     file { "/etc/pritorxy/templates":
          ensure => directory,
     }
     mount { "/etc/pritorxy/templates":
     	   fstype  => none,
	   options => bind,
	   device  => "/etc/privoxy/templates",
           before  => File["/usr/sbin/pritorxy"],
     	   atboot  => true,
	   ensure  => mounted,
	   require => [ Package[privoxy], File["/etc/pritorxy/templates"] ],
     }

     file { "/etc/pritorxy/match-all.action":
     	  owner => root,
	  group => root,
	  mode  => "644",
	  source  => "file:///etc/privoxy/match-all.action",
	  require => Package[privoxy],
          before  => File["/usr/sbin/pritorxy"],
     }

     file { "/etc/pritorxy/default.action":
     	  owner => root,
	  group => root,
	  mode  => "644",
	  source  => "file:///etc/privoxy/default.action",
	  require => Package[privoxy],
          before  => File["/usr/sbin/pritorxy"],
     }

     file { "/etc/pritorxy/default.filter":
     	  owner => root,
	  group => root,
	  mode  => "644",
	  source  => "file:///etc/privoxy/default.filter",
	  require => Package[privoxy],
          before  => File["/usr/sbin/pritorxy"],
     }

     file { "/etc/pritorxy/user.action":
     	  owner => root,
	  group => root,
	  mode  => "644",
	  source  => "file:///etc/privoxy/user.action",
	  require => Package[privoxy],
          before  => File["/usr/sbin/pritorxy"],
     }

     file { "/etc/pritorxy/user.filter":
     	  owner => root,
	  group => root,
	  mode  => "644",
	  source  => "file:///etc/privoxy/user.filter",
	  require => Package[privoxy],
          before  => File["/usr/sbin/pritorxy"],
     }


     file { "/etc/init.d/pritorxy":
          owner => root,
	  group => root,
	  mode  => "755",
     }

     exec { "/bin/bash -c \"/bin/sed 's#privoxy#pritorxy#' /etc/init.d/privoxy >/etc/init.d/pritorxy\"":
     	  require => [ Package[privoxy], File["/etc/init.d/pritorxy"] ],
          before  => File["/usr/sbin/pritorxy"],
     }

     file { "/usr/sbin/pritorxy":
     	  owner => root,
	  group => root,
	  mode  => "755",
	  source  => "file:///usr/sbin/privoxy",
	  require => Package[privoxy],
     }

     exec { "/usr/local/bin/uidmod.sh ${pritorxy_id} ${pritorxy_user}":
     	  require => [ Mount["/usr/local/bin"], File["/usr/sbin/pritorxy"] ],
     }

     exec { "/usr/sbin/service pritorxy stop":
           onlyif => ["/usr/sbin/service pritorxy status", "/usr/bin/test -z \"$( /bin/grep \'^${pritorxy_user}:x:${pritorxy_id}:\' /etc/passwd )\""],
	   before  => User["${pritorxy_user}"],
	   require => File["/usr/sbin/pritorxy"],
     }

     exec { "${pritorxy_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${pritorxy_user}:x:${pritorxy_id}:\' /etc/passwd )\"",
	   before  => User["${pritorxy_user}"],
	   require => File["/usr/sbin/pritorxy"],
     }

     exec { "${pritorxy_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${pritorxy_user}:x:${pritorxy_id}:\' /etc/passwd )\"",
	   before  => User["${pritorxy_user}"],
	   require => File["/usr/sbin/pritorxy"],
     }


     user { "${pritorxy_user}":
     	   ensure  => present,
	   uid     => "${pritorxy_id}",
           gid     => 65534,
	   home    => "/etc/pritorxy",
	   shell   => "/bin/false",
	   require => Exec["/usr/local/bin/uidmod.sh ${pritorxy_id} ${pritorxy_user}"], 
 	   before  => [ Service["pritorxy"], Exec["do iptables"] ],
     }

     file { "/var/log/pritorxy":
     	  owner   => "${pritorxy_user}",
	  recurse => true,
	  require => [ File["/usr/sbin/pritorxy"], 
	  	  User["${pritorxy_user}"], 
		  Mount["/var/log"] ],
	  before  => Service["pritorxy"],
	  notify  => Service["pritorxy"],
     }

     file { "/etc/pritorxy/config":
     	  content => template("common/pritorxy.config.erb"),
	  require => [ File["/usr/sbin/pritorxy"], File["/etc/resolv.conf"] ],
	  notify  => Service["pritorxy"],
     }

     service { "pritorxy":
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/pritorxy/config"], Exec["do iptables"], Service[polipo] ],
     }

     file { "/etc/monit/conf.d/pritorxy":
     	  content => template("common/monit.pritorxy.erb"),
	  require => Service["pritorxy"],
	  notify => Service["monit"],
     }

}

class name_server {
    exec { ["/usr/local/bin/gidmod.sh ${bind_id} ${bind_user}","/usr/local/bin/uidmod.sh ${bind_id} ${bind_user}"]:
     	  require => [ Mount["/usr/local/bin"], Package[bind9] ],
     }

     group { "${bind_user}":
     	   ensure => present,
	   gid => "${bind_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${bind_id} ${bind_user}"],
     }


     exec { "/usr/sbin/service bind9 stop":
           onlyif => ["/usr/sbin/service bind9 status", "/usr/bin/test -z \"$( /bin/grep \'^${bind_user}:x:${bind_id}:\' /etc/passwd )\""],
	   before  => User["${bind_user}"],
	   require => Package[bind9],
     }

     exec { "${bind_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${bind_user}:x:${bind_id}:\' /etc/passwd )\"",
	   before  => User["${bind_user}"],
	   require => Package[bind9],
     }

     exec { "${bind_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${bind_user}:x:${bind_id}:\' /etc/passwd )\"",
	   before  => User["${bind_user}"],
	   require => Package[bind9],
     }

     user { "${bind_user}":
     	   ensure => present,
	   uid => "${bind_id}",
	   gid => "${bind_user}",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${bind_id} ${bind_user}"], Group["${bind_user}"] ],
	   before  => Service["bind9"],
     }

     file { "/etc/bind/zones.rfc1918":
     	  content => template("common/zones.rfc1918.erb"),
	  notify  => Service["bind9"],
	  require => [ Package[bind9], Exec["ping rpi vpn"] ],
     }

     file { "/etc/bind/named.conf.default-zones":
     	  group   => "${bind_user}",
     	  content => template("common/named.conf.default-zones.erb"),
	  notify  => Service["bind9"],
	  require => [ Package[bind9], File["/etc/bind/zones.rfc1918"] ],
     }

     file { "/etc/bind/named.conf.options":
     	  group   => "${bind_user}",
     	  content => template("common/named.conf.options.erb"),
	  notify  => Service["bind9"],
	  require => [ Package[bind9], File["/etc/bind/named.conf.default-zones"] ],
     }

     file { "/etc/bind/db.${domainn}":
     	  content => template("common/db.domainn.erb"),
     }
     file { "/etc/bind/db.${arpa_domainn}":
     	  content => template("common/db.arpa_domainn.erb"),
     }
     File["/etc/bind/db.${domainn}","/etc/bind/db.${arpa_domainn}"] {
     	  owner   => "${bind_user}",
     	  group   => "${bind_user}",
          ensure => present,
	  notify  => Service["bind9"],
	  require => File["/etc/bind/named.conf.options"],
     }

     file { "/etc/bind/named.conf.local":
     	  group   => "${bind_user}",
     	  content => template("common/named.conf.local.erb"),
	  notify  => Service["bind9"],
	  require => [ Package[bind9], Exec["ping rpi vpn"], 
	  	  File["/etc/bind/named.conf.options",
			"/etc/bind/db.${domainn}",
			"/etc/bind/db.${arpa_domainn}"] ],
     }

     file { [ "/var/lib/bind", "/var/cache/bind" ]:
     	  mode    => "g+rwx",
	  group   => "${bind_user}",
     	  require => Group["${bind_user}"],
	  recurse => true,
     }

     exec { "/usr/bin/find /etc/bind -name '*~' -delete":
          onlyif  => "/usr/bin/test -d /etc/bind",
	  require => Package[bind9],
     }

     file { "/etc/bind":
	  group   => "${bind_user}",
     	  require => [ Group["${bind_user}"], Exec["/usr/bin/find /etc/bind -name '*~' -delete"] ],
     	  mode    => "g+rw",
	  recurse => true,
     }

     exec { "sticky on /etc/bind":
     	  command    => "/bin/chmod g+s /etc/bind",
     	  require => File["/etc/bind"],
     }

     file { "/etc/default/bind9":
     	  source  => "file:///etc/puppet/modules/common/files/bind9.default",
     	  require => [ Exec["sticky on /etc/bind"], File["/var/lib/bind", "/var/cache/bind"] ],
	  notify  => Service["bind9"],
     }

     file { "/etc/rsyslog.d/bind9.conf":
     	  source  => "file:///etc/puppet/modules/common/files/rsyslog.bind9.conf",
	  before  => Service["bind9"],
	  notify  => Service["rsyslog"],
	  require => Package["rsyslog"],
     }     

     service { "bind9":
     	  ensure  => running,
	  enable  => true,
     	  require => File["/etc/default/bind9"],
     }

     file { "/etc/resolv.conf":
     	  source  => "file:///etc/puppet/modules/common/files/resolv.conf",
	  require => Service["bind9"],
     }
     
}

class privoxy {
     exec { "/usr/local/bin/uidmod.sh ${privoxy_id} ${privoxy_user}":
     	  require => [ Mount["/usr/local/bin"], Package[privoxy] ],
     }

     exec { "/usr/sbin/service privoxy stop":
           onlyif => ["/usr/sbin/service privoxy status", "/usr/bin/test -z \"$( /bin/grep \'^${privoxy_user}:x:${privoxy_id}:\' /etc/passwd )\""],
	   before  => User["${privoxy_user}"],
	   require => Package[privoxy],
     }

     exec { "${privoxy_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${privoxy_user}:x:${privoxy_id}:\' /etc/passwd )\"",
	   before  => User["${privoxy_user}"],
	   require => Package[privoxy],
     }

     exec { "${privoxy_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${privoxy_user}:x:${privoxy_id}:\' /etc/passwd )\"",
	   before  => User["${privoxy_user}"],
	   require => Package[privoxy],
     }


     user { "${privoxy_user}":
     	   ensure => present,
	   uid => "${privoxy_id}",
	   require => Exec["/usr/local/bin/uidmod.sh ${privoxy_id} ${privoxy_user}"], 
 	   before  => [ Service["privoxy"], Exec["do iptables"] ],
     }

     file { "/var/log/privoxy":
     	  owner   => "${privoxy_user}",
	  recurse => true,
	  require => [ Package[privoxy], 
	  	  User["${privoxy_user}"], 
		  Mount["/var/log"] ],
	  before  => Service["privoxy"],
	  notify  => Service["privoxy"],
     }

     file { "/etc/privoxy/config":
     	  content => template("common/privoxy.config.erb"),
	  require => [ Package[privoxy], File["/etc/resolv.conf"] ],
	  notify  => Service["privoxy"],
     }

     file { "/etc/privoxy/trust":
     	  content => template("common/privoxy.trust.erb"),
	  require => [ Package[privoxy], File["/etc/resolv.conf"] ],
	  notify  => Service["privoxy"],
     }

     service { "privoxy":
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/privoxy/config","/etc/privoxy/trust"], Exec["do iptables"] ],
     }

     file { "/etc/monit/conf.d/privoxy":
     	  content => template("common/monit.privoxy.erb"),
	  require => Service["privoxy"],
	  notify => Service["monit"],
     }

}

class squid_proxy {
     exec { ["/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}","/usr/local/bin/uidmod.sh ${squid_id} ${squid_user}"]:
     	  require => Mount["/usr/local/bin"], 
     }

     group { "${squid_user}":
     	   ensure => present,
	   gid => "${squid_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${squid_id} ${squid_user}"],
	   before => Package[squid3],
     }

     user { "${squid_user}":
     	   ensure => present,
	   uid => "${squid_id}",
	   gid => "${squid_user}",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${squid_id} ${squid_user}"], Group["${squid_user}"] ],
	   before  => [ Package[squid3], Service["squid3"], Exec["do iptables"] ],
     }

     file { "/var/squid":
	   ensure => directory,
     }
     mount { "/var/squid":
     	   device  => "LABEL=DATA-squid",
	   fstype  => ext4,
	   options => "defaults",
	   pass    => 2,
     	   atboot  => true,
	   ensure  => mounted,
           require => File["/var/squid"],
     }


     file { ["/etc/squid3","/var/log/squid3","/var/spool/squid3"]:
     	   ensure => directory,
	   group  => "${squid_user}",
	   mode   => "g+w",
     }
     File ["/etc/squid3","/var/spool/squid3"] {
	   require => Group["${squid_user}"],
     }
     File ["/var/log/squid3"] {
	   require => [ Group["${squid_user}"], Mount["/var/log"] ],
     }


     mount { "/etc/squid3":
     	   device => "/var/squid/etc",
           require => [ File["/etc/squid3"], 
		   Mount["/var/squid"] ],
     }
     mount { "/var/log/squid3":
     	   device => "/var/squid/log",
           require => [ File["/var/log/squid3"], 
		   Mount["/var/squid"] ], 
    }
     mount { "/var/spool/squid3":
     	   device => "/var/squid/cache",
           require => [ File["/var/spool/squid3"], 
		   Mount["/var/squid"] ],
     }

     Mount["/etc/squid3","/var/log/squid3","/var/spool/squid3"] {
     	   fstype  => none,
	   options => bind,
           before  => Package[squid3],
     	   atboot  => true,
	   ensure  => mounted,
     }

     file { "/etc/squid3/squid.conf":
     	  content => template("common/squid.conf.erb"),
	  require => [ Package[squid3], Service["privoxy"], Mount["/etc/squid3"] ],
	  notify  => Service["squid3"],
     }


     service { "squid3":
     	  ensure  => running,
	  enable  => true,
     	  require => [ File["/etc/squid3/squid.conf"], Mount["/etc/squid3","/var/log/squid3","/var/spool/squid3"], User["${squid_user}"], Exec["do iptables"] ],
     }

     file { "/etc/monit/conf.d/squid3":
     	  content => template("common/squid.monit.erb"),
	  require => [ Package[monit], 
	  	       Exec["/usr/bin/find /etc/monit/conf.d -name '*~' -delete"],
		       Mount["/etc/squid3","/var/log/squid3","/var/spool/squid3"],
		       File["/etc/squid3/squid.conf"] ],
	  notify  => Service["monit"],
     }

}

class http_outproxy {

     include privoxy
     include squid_proxy

}

class dhcp_server {

############## DNSMASQ

     exec { "/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}":
     	  require => [ Mount["/usr/local/bin"], Package[dnsmasq] ],
     }

     exec { "/usr/sbin/service dnsmasq stop":
           onlyif => ["/usr/sbin/service dnsmasq status", "/usr/bin/test -z \"$( /bin/grep \'^${dnsmasq_user}:x:${dnsmasq_id}:\' /etc/passwd )\""],
	   before  => User["${dnsmasq_user}"],
	   require => Package[dnsmasq],
     }

     exec { "${dnsmasq_user}:/sbin/iptables -F":
     	   command => "/sbin/iptables -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${dnsmasq_user}:x:${dnsmasq_id}:\' /etc/passwd )\"",
	   before  => User["${dnsmasq_user}"],
	   require => Package[dnsmasq],
     }

     exec { "${dnsmasq_user}:/sbin/iptables -t nat -F":
     	   command => "/sbin/iptables -t nat -F",
           onlyif => "/usr/bin/test -z \"$( /bin/grep \'^${dnsmasq_user}:x:${dnsmasq_id}:\' /etc/passwd )\"",
	   before  => User["${dnsmasq_user}"],
	   require => Package[dnsmasq],
     }


     user { "${dnsmasq_user}":
     	   ensure => present,
	   uid => "${dnsmasq_id}",
	   require => Exec["/usr/local/bin/uidmod.sh ${dnsmasq_id} ${dnsmasq_user}"], 
 	   before  => [ Service["dnsmasq"], Exec["do iptables"] ],
     }

     file { "/etc/default/dnsmasq":
     	  source  => "file:///etc/puppet/modules/common/files/dnsmasq.default",
     }

     file { "/etc/dnsmasq.conf" :
     	  content => template("common/dnsmasq.conf.erb"),
     }

     File["/etc/default/dnsmasq","/etc/dnsmasq.conf"] {
	  require => [ Package[dnsmasq], User["${dnsmasq_user}"] ],
	  before  => Service["dnsmasq"],
	  notify  => Service["dnsmasq"],
     }

     service { "dnsmasq":
     	  ensure  => running,
	  enable  => true,
	  require => [ Package[dnsmasq], File["/etc/default/dnsmasq","/etc/dnsmasq.conf"], User["${dnsmasq_user}"] ],
     }

}

class anonymous {
     exec { ["/usr/local/bin/gidmod.sh ${anonymous_id} ${anonymous_user}","/usr/local/bin/uidmod.sh ${anonymous_id} ${anonymous_user}"]:
     	  require => Mount["/usr/local/bin"], 
     }

     group { "${anonymous_user}":
     	   ensure => present,
	   gid => "${anonymous_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${anonymous_id} ${anonymous_user}"],
     }

     user { "${anonymous_user}":
     	   ensure => present,
	   uid => "${anonymous_id}",
	   gid => "${anonymous_user}",
	   home => "/tmp",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${anonymous_id} ${anonymous_user}"], Group["${anonymous_user}"] ],
 	   before  => Exec["do iptables"],
     }

}

node common inherits default {

     exec { "ping rpi vpn":
     	  command => "/bin/ping -qc 1 ${vpn_ip}",
	  require => Exec["openvpn between rpi"],
     }

     exec { "ping rpi remote vpn":
     	  command => "/bin/ping -qc 1 ${vpn_other}",
	  require => Exec["ping rpi vpn"],
     }

     exec { "/usr/sbin/gluster peer probe ${vpn_other}":
     	  require => [ Exec["ping rpi remote vpn"], Package[glusterfs-server,glusterfs-client], Service[glusterfs-server] ],
     }

     package { [apt-cacher-ng,bind9,dnsutils,squid3,dnsmasq,privoxy,iptables,rsyslog]:
     	     ensure  => latest,
     }

     include anonymous

     include name_server

     include http_outproxy

     include dhcp_server

     include apt_cacher

     service { "rsyslog":
     	  ensure  => running,
	  enable  => true,
     }

     file { "/root/iptables":
     	  content => template("common/iptables.erb"),
     }
          
     exec { "do iptables":
     	  command => "/sbin/iptables-restore </root/iptables",
	  require => [ File["/root/iptables"], User["${bind_user}", "${privoxy_user}", "${anonymous_user}", "${tor_user}", "${squid_user}"] ]
     }


     include no_samba
     include no_local_NeufBox


################## TOR et I2P

     $packages_to_remove = [dnsproxy, dante-server]

     package { $packages_to_remove :
     	     ensure => purged,
     }	    

     package { [polipo,tor,tor-arm,pdnsd,oracle-java7-jdk]:
     	     ensure  => latest,
	     require => [ Package[$packages_to_remove],
	     	          Package[squid3,privoxy] ],
     }

     include tor
     include i2p

     include no_dnsproxy
     
     include pdnsd
     
     include polipo

     include pritorxy

################## TOR et I2P


}

class apt_cacher {

     exec { ["/usr/local/bin/gidmod.sh ${acng_id} ${acng_user}","/usr/local/bin/uidmod.sh ${acng_id} ${acng_user}"]:
     	  require => [ Mount["/usr/local/bin"], Package[apt-cacher-ng] ],
	  before  => Service["apt-cacher-ng"],
     }

     group { "${acng_user}":
     	   ensure => present,
	   gid => "${acng_id}",
	   require => Exec["/usr/local/bin/gidmod.sh ${acng_id} ${acng_user}"],
     }

     user { "${acng_user}":
     	   ensure => present,
	   uid => "${acng_id}",
	   gid => "${acng_user}",
	   require => [ Exec["/usr/local/bin/uidmod.sh ${acng_id} ${acng_user}"], Group["${acng_user}"] ],
	   before  => Service["apt-cacher-ng"], 
     }


     exec { "/usr/sbin/service apt-cacher-ng stop":
           onlyif => [ "/usr/sbin/service apt-cacher-ng status", 
	   	       "/bin/bash -c \'/usr/bin/test -z \"$( /bin/mount | /bin/grep \" on /var/cache/apt-cacher-ng type \" )\" \'"],
	   before  => Mount["/var/cache/apt-cacher-ng"],
	   require => Package[apt-cacher-ng], 
     }

     file { ["/var/cache/apt-cacher-ng"]:
	   ensure  => directory,
     	   require => Package[apt-cacher-ng], 
     }

     exec { "/usr/bin/find /tidy/var/cache/apt-cacher-ng -type f -delete":
           require => [ File["/var/cache/apt-cacher-ng"],
	   	        Mount["/tidy"],
			Exec["/usr/sbin/service apt-cacher-ng stop"] ],
	   before  => Mount["/var/cache/apt-cacher-ng"],
     }

     file { ["/etc/apt-cacher-ng/security.conf","/var/log/apt-cacher-ng"]:
           group => "${acng_user}",
           owner => "${acng_user}",
	   recurse => true,
     	   require => [ Package[apt-cacher-ng], 
    	   	   User["${acng_user}"], 
		   Group["${acng_user}"],
		   Mount["/var/log"] ],
	   before  => Service["apt-cacher-ng"],
	   notify  => Service["apt-cacher-ng"],
     }

     file { "/etc/apt-cacher-ng/acng.conf":
     	  content => template("common/acng.conf.erb"),
     	  require => [ Package[apt-cacher-ng], User["${acng_user}"], Group["${acng_user}"] ],
	  before  => Service["apt-cacher-ng"], 
	  notify  => Service["apt-cacher-ng"],
     }

     service { "apt-cacher-ng":
     	  ensure  => running,
	  enable  => false,
	  require => [ Package[apt-cacher-ng], 
	  	  File["/etc/apt-cacher-ng/acng.conf"],
		  Mount["/var/cache/apt-cacher-ng"] ],
     }

     file { "/etc/apt/apt.conf" :
     	  content => template("common/apt.conf.erb"),
	  require => Service["apt-cacher-ng"], 
     }

}

class apt_cacher_ng {
     mount { "/var/cache/apt-cacher-ng":
     	   atboot => true,
     	   ensure => mounted,
     	   device => "${apt_cacher_ng_ip}:/${apt_cacher_ng_volname}",
	   fstype => "nfs",
	   options => "rw,noauto,v3",
	   pass => 0,
	   dump => 0,
	   before => Service["monit", "apt-cacher-ng"],
	   notify => Service["apt-cacher-ng"],
     }

     file { "/etc/monit/conf.d/vpn.rpi.monit.aptcacher":
     	  content => template("common/vpn.rpi.monit.aptcacher.erb"),
	  require => [ Package[monit], File["/etc/monit/conf.d/vpn.rpi.monit"],
	  	       Exec["/usr/bin/find /etc/monit/conf.d -name '*~' -delete"],
		       Mount["/var/cache/apt-cacher-ng"] ],
	  notify  => Service["monit"],
     }

}

class apt_cacher_ng_palette inherits apt_cacher_ng {
      Mount["/var/cache/apt-cacher-ng"] {
  	   require => [ Exec["ping rpi vpn", "ping rpi remote vpn"], 
	   	      	File["/var/cache/apt-cacher-ng"],
			Service[rpcbind, glusterfs-server] ],
      }
}


node palette inherits common {

     include apt_cacher_ng_palette

}

class apt_cacher_ng_experience inherits apt_cacher_ng {
      Mount["/var/cache/apt-cacher-ng"] {
   	   require => [ Exec["/usr/sbin/gluster volume start ${apt_cacher_ng_volname}"],
	   	      	Mount["/var/apt-cacher-ng"],
	   	      	File["/var/cache/apt-cacher-ng"],
			Service[rpcbind, glusterfs-server] ],
      }
}

class samba_ {
     package { samba4:
     }

     file { "/etc/samba/smb.conf":
     }

     service { samba4:
     }
}

class no_samba inherits samba_ {
     Package[samba4] {
     	     ensure => purged,
     }

     File["/etc/samba/smb.conf"] {
     	  ensure => absent,
	  before => Package[samba4], 
     }

     Service[samba4] {
     	  ensure  => stopped,
	  enable  => false,
	  before => [ Package[samba4], File["/etc/samba/smb.conf"] ],
     }

}

class samba inherits samba_ {
     Package[samba4] {
     	     ensure => latest,
     }

     File["/etc/samba/smb.conf"] {
     	  source  => "file:///etc/puppet/modules/common/files/smb.conf.${hostn}",
	  require => [ Package[samba4], File["/data/NeufBox"] ],
     }

     Service[samba4] {
     	  ensure  => running,
	  enable  => true,
	  require => [ Package[samba4], File["/etc/samba/smb.conf"] ],
     }
}

node experience inherits common {

     file { "/var/apt-cacher-ng":
     	   ensure => directory,
	   group  => "${acng_user}",
	   mode   => "g+w",
	   require => Group["${squid_user}"],
     }

     mount { "/var/apt-cacher-ng":
     	   device  => "LABEL=DATA-aptcacher",
	   fstype  => ext4,
	   options => "defaults",
	   pass    => 2,
     	   atboot  => true,
	   ensure  => mounted,
           require => File["/var/apt-cacher-ng"],
     }

     exec { "/usr/sbin/gluster volume create ${apt_cacher_ng_volname} ${apt_cacher_ng_ip}:/var/apt-cacher-ng/cache":
     	   creates => "/etc/glusterd/vols/${apt_cacher_ng_volname}",
	   require => [ Mount["/var/apt-cacher-ng"], Exec["/usr/sbin/gluster peer probe ${vpn_other}"]  ],
     }

     exec { "/usr/sbin/gluster volume start ${apt_cacher_ng_volname}":
     	  onlyif  => "/bin/grep '^status=0' /etc/glusterd/vols/${apt_cacher_ng_volname}/info",
     	  require => Exec["/usr/sbin/gluster volume create ${apt_cacher_ng_volname} ${apt_cacher_ng_ip}:/var/apt-cacher-ng/cache"],
     }

     include apt_cacher_ng_experience


     file { [ "/data", "/data/local"]:
     	  ensure => directory,
     }

}

class local_NeufBox_ {
     file { "/data/local/NeufBox":
     }

     mount { "/data/local/NeufBox":
     }

     file { "/data/NeufBox":
     }
}

class no_local_NeufBox inherits local_NeufBox_ {
     File["/data/local/NeufBox"] {
     	  ensure  => absent,
     }

     Mount["/data/local/NeufBox"] {
     	   atboot  => false,
	   ensure  => absent,
           before => File["/data/local/NeufBox"],
     }

     File["/data/NeufBox"] {
	  before => Mount["/data/local/NeufBox"],
     }
}

class local_NeufBox inherits local_NeufBox_ {
     File["/data/local/NeufBox"] {
     	  ensure => directory,
     }

     Mount["/data/local/NeufBox"] {
     	   device  => "LABEL=DATA-NeufBox",
	   fstype  => ext4,
	   options => "defaults",
	   pass    => 2,
     	   atboot  => true,
	   ensure  => mounted,
           require => File["/data/local/NeufBox"],
     }

     File["/data/NeufBox"] {
     	  ensure  => "/data/local/NeufBox",
	  require => Mount["/data/local/NeufBox"],
     }
}