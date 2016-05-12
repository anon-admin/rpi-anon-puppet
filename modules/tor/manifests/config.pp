class tor::config (
  $tor_id = $tor::tor_id, 
  $tor_user = $tor::tor_user,
  $tor_ip = $tor::tor_ip,
  $tor_port = $tor::tor_port,
  $tor_external_public_port = $tor::tor_external_public_port,
  $tor_external_port = $tor::tor_external_port,
  $tor_dns_port = $tor::tor_dns_port,
  $tor_oignon_pages_port = $tor::tor_oignon_pages_port
) inherits tor {

  exec { ["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}", "/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"]: require => [
      Mount["/usr/local/bin"],
      Package[tor]], }

  file { ["/var/tor/etc", "/var/tor/log", "/var/tor/lib"]:
    ensure => directory,
    before => Mount["/etc/tor", "/var/log/tor", "/var/lib/tor"],
  }

  file { ["/etc/tor", "/var/log/tor"]:
    ensure => directory,
    mode   => "g+rw",
    before => Group["${tor_user}"],
  }

  file { "/var/lib/tor":
    ensure => directory,
    before => Group["${tor_user}"],
  }

  exec { "/usr/bin/find /var/log/tor -name '*~' -delete": onlyif => "/usr/bin/test -d /var/log/tor", }

  File["/var/log/tor"] {
    require => Exec["/usr/bin/find /var/log/tor -name '*~' -delete"],
    recurse => true,
  }

  mount { "/etc/tor":
    device  => "/var/tor/etc",
    require => File["/var/tor/etc", "/etc/tor"],
  }

  mount { "/var/log/tor":
    device  => "/var/tor/log",
    require => File["/var/tor/log", "/var/log/tor"],
  }

  mount { "/var/lib/tor":
    device  => "/var/tor/lib",
    require => File["/var/tor/lib", "/var/lib/tor"],
  }

  exec { [
    "/bin/chown -R :${tor_user} /etc/tor",
    "/bin/chown -R :${tor_user} /var/log/tor",
    "/bin/chown -R :${tor_user} /var/lib/tor"]:
    require => [Mount["/etc/tor", "/var/log/tor", "/var/lib/tor"], Package["tor"]],
    before  => Service[tor],
    notify  => Service[tor],
  }

  Mount[
    "/etc/tor", "/var/log/tor", "/var/lib/tor"] {
    fstype  => none,
    options => bind,
    before  => Package[tor],
    atboot  => true,
    ensure  => mounted,
    notify  => Service[tor],
  }

  exec { "/etc/init.d/tor stop":
    onlyif  => ["/etc/init.d/tor status", "/usr/bin/test -z \"$( /bin/grep \'^${tor_user}:x:${tor_id}:\' /etc/passwd )\""],
    before  => User["${tor_user}"],
    require => Package[tor],
    notify  => Service[tor],
  }

  group { "${tor_user}":
    ensure => present,
    gid    => "${tor_id}",
  }
  Exec["/usr/local/bin/gidmod.sh ${tor_id} ${tor_user}"] -> Group["${tor_user}"]

  user { "${tor_user}":
    ensure => present,
    uid    => "${tor_id}",
    gid    => "${tor_user}",
    before => Service["tor"],
    notify => Service[tor],
  }
  Exec["/usr/local/bin/uidmod.sh ${tor_id} ${tor_user}"] -> User["${tor_user}"]
  Group["${tor_user}"] -> User["${tor_user}"]

  file { "/etc/default/tor": source => "puppet:///modules/tor/tor.default", }

  $hostname_array = split($hostname, "_")
  $real_hostname = $hostname_array[0]

  file { "/etc/tor/torrc": content => template("tor/torrc.erb"), }

  file { "/var/lib/tor/.torrc":
    ensure  => link,
    target  => "/etc/tor/torrc",
    require => Mount["/var/lib/tor"],
    before  => Service["tor"],
  }

  File[
    "/etc/default/tor", "/etc/tor/torrc"] {
    require => [Mount["/etc/tor"], Package[tor]],
    before  => Service["tor"],
    notify  => Service["tor"],
  }

  exec { "sticky on /var/log/tor":
    command => "/bin/chmod g+s /var/log/tor",
    require => Mount["/var/log/tor"],
  }

}
