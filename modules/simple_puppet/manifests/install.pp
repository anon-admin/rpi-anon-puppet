class simple_puppet::install inherits conf::config::wget {

  include conf::config::apt

  Package["wget"] -> Exec["/usr/bin/wget -4 http://apt.puppetlabs.com/puppetlabs-release-${lsbdistcodename}.deb"]

  # monthly update
  cron { "force apt.puppetlabs update":
    command => "/usr/bin/dpkg -r puppetlabs-release ; /bin/rm /tmp/puppetlabs-release-${lsbdistcodename}.deb",
    # ensure  => absent,
    user    => root,
    special => 'monthly',
    require => Service["cron"],
  }

  exec { "/usr/bin/wget -4 http://apt.puppetlabs.com/puppetlabs-release-${lsbdistcodename}.deb":
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

  package { ["puppet", "facter","puppetmaster"]: }

  file { ["${simple_puppet::conf_root_dir}","${simple_puppet::conf_root_dir}/modules","${simple_puppet::conf_root_dir}/${simple_puppet::hiera_dir}"]: }

}

