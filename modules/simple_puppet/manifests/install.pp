class simple_puppet::install inherits conf::install::wget {
  Package["wget"] {
    ensure => latest, }
  Package["wget"] -> Exec["/usr/bin/wget https://apt.puppetlabs.com/puppetlabs-release-${lsbdistcodename}.deb"]

  # monthly update
  cron { "force apt.puppetlabs update":
    command => "/usr/bin/dpkg -r puppetlabs-release ; /bin/rm /tmp/puppetlabs-release-${lsbdistcodename}.deb",
    # ensure  => absent,
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

  package { ["puppet", "facter"]:
    ensure  => latest,
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

  file { "/etc/puppet/modules": ensure => directory, }
}

