class simple_puppet::config inherits simple_puppet::install {
  Package[
    "puppet", "facter"] {
    ensure  => latest,
    require => Exec["/usr/bin/dpkg -i puppetlabs-release-${lsbdistcodename}.deb", "/usr/bin/apt-get update"],
  }

  Package["puppetmaster"] {
    ensure  => purged,
    require => Package["puppet"],
  }

  File["/etc/puppet"] {
    ensure  => directory,
    require => Package["puppet"],
  }

  File["/etc/puppet/modules"] {
    ensure => directory, }

}