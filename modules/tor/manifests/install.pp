class tor::install inherits tor {
  
  file { "/etc/apt/sources.list.d/tor.list":
    owner  => root,
    before => Exec["/usr/bin/gpg --keyserver keyserver.ubuntu.com --recv 886DDD89"],
  }

  exec { "/usr/bin/gpg --keyserver keyserver.ubuntu.com --recv 886DDD89":
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

  package { ["tor", "deb.torproject.org-keyring", "tor-geoipdb"]: }

  File["/etc/apt/sources.list.d/tor.list"] {
    source => "puppet:///modules/tor/tor.sources.list", }

  Package[
    "tor", "deb.torproject.org-keyring", "tor-geoipdb"] {
    ensure  => latest,
    require => Exec["/usr/bin/apt-get update"],
  }

  case $architecture {
    'armv6l' : {
      # Raspian in Pi1, repository does not work
      #
      # File["/etc/apt/sources.list.d/tor.list"] {
      #   ensure => absent,
      #}
      # Package["tor", "deb.torproject.org-keyring","tor-geoipdb"] {
      #   ensure  => absent,
      #}


      # -rwxr-xr-x root/root   ./usr/bin/tor-gencert
      # -rwxr-xr-x root/root   ./usr/bin/tor-resolve
      # -rwxr-xr-x root/root   ./usr/bin/tor
      # -rwxr-xr-x root/root   ./usr/bin/torify

      file { "/usr/local/share/tor":
        ensure => link,
        target => "/usr/share/tor",
      }

      file { "/usr/bin/tor":
        source => "/var/tor/stable/src/or/tor",
        notify => Service["tor"],
      }

      file { "/usr/bin/torify": source => "/var/tor/stable/contrib/client-tools/torify", }

      file { "/usr/bin/tor-gencert": source => "/var/tor/stable/src/tools/tor-gencert", }

      file { "/usr/bin/tor-resolve": source => "/var/tor/stable/src/tools/tor-resolve", }

      File[
        "/usr/local/share/tor", "/usr/bin/tor", "/usr/bin/torify", "/usr/bin/tor-gencert", "/usr/bin/tor-resolve"] {
        require => Package["tor"],
        before  => Service["tor"],
        owner   => root,
        group   => root,
        mode    => 755,
      }

    }
  }

}
