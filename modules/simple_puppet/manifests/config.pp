class simple_puppet::config inherits simple_puppet::install {

  contain simple_puppet

  Package[
    "puppet", "facter"] {
    ensure  => latest,
    require => Exec["/usr/bin/dpkg -i puppetlabs-release-${lsbdistcodename}.deb", "/usr/bin/apt-get update"],
  }

  Package["puppetmaster"] {
    ensure  => purged,
    require => Package["puppet"],
  }

  File["${simple_puppet::conf_root_dir}"] {
    ensure  => directory,
    require => Package["puppet"],
  }

  File["${simple_puppet::conf_root_dir}/modules","${simple_puppet::conf_root_dir}/${simple_puppet::hiera_dir}"] {
    ensure => directory, }

  $passwd_hiera_file = "${simple_puppet::hiera_dir}/passwords.yaml"


  file_line { "gitignore ${passwd_hiera_file}":
    path => "${simple_puppet::conf_root_dir}/.gitignore",
    line => "${passwd_hiera_file}",
  }

}