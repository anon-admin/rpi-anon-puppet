class i2p::install inherits i2p {
  package { "oracle-java8-jdk": ensure => latest, }


  exec { "/usr/bin/wget -4 http://geti2p.net/_static/i2p-debian-repo.key.asc":
    cwd => "/tmp",
    require => Package["wget"],
  }

  exec { "/usr/bin/apt-key add i2p-debian-repo.key.asc":
    cwd => "/tmp",
    require => Exec["/usr/bin/wget -4 http://geti2p.net/_static/i2p-debian-repo.key.asc"],
  }

  file { "/etc/apt/sources.list.d/i2p.list":
    owner  => root,
    before => Exec["/usr/bin/apt-get update"],
  }
  File["/etc/apt/sources.list.d/i2p.list"] ~> Exec["/usr/bin/apt-get update"]
  
  package { ["i2p", "i2p-keyring"]: }

  File["/etc/apt/sources.list.d/i2p.list"] {
    content => template("i2p/i2p.sources.list"), }

  Package[
    "i2p", "i2p-keyring"] {
    ensure  => latest,
    require => Exec["/usr/bin/apt-get update"],
  }

  file { "/etc/apt/sources.list":
    owner  => root,
    before => Exec["/usr/bin/apt-get update"],
    content => template("i2p/sources.list.erb"),
  }  
}


# root@myi2p:/usr/share/i2p# ls
# blocklist.txt  clients.config  eepsite  hisi2py.txt  i2psnark.config   lib            systray.config
# certificates   docs            geoip    hosts.txt    i2ptunnel.config  router.config  webapps


#   36  wget https://geti2p.net/_static/i2p-debian-repo.key.asc
#   37  wget http://geti2p.net/_static/i2p-debian-repo.key.asc
#   38  apt-key add i2p-debian-repo.key.asc
#   39  apt-get update
#   40  apt-get install i2p i2p-keyring
#   41  apt-get install i2p i2p-keyring
#   42  which i2prouter
#   43  ls /var/lib/i2p/
#   44  i2prouter
#   45  cd /var/lib
#   46  ls
#   47  ls i2p/
#   48  cd /usr/lib
#   49  ls
#   50  cd /var/cache/
#   51  ls
#   52  cd /var/spool/
#   53  ls
#   54  cd /opt
#   55  ls
#   56  cd /
#   57  find . -type d -name 'i2p*'
#   58  cd /var/i2p/
#   59  ls
#   60  cd /etc/i2p/
#   61  ls
#   62  less wrapper.config
#   63  cat wrapper.config
#   64  cd /usr/share/
#   65  cd i2p/
#   66  ls
#   67  cat router.config
