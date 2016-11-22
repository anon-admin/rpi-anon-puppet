class simple_puppet::puppetadmin::definition(
  $puppetadmin_user = $simple_puppet::puppetadmin_user,
  $puppetadmin_id = $simple_puppet::puppetadmin_id,
  $puppetadmin_shell = $simple_puppet::puppetadmin_shell) inherits simple_puppet {
  

  exec { "/usr/local/bin/uidmod.sh ${puppetadmin_id} ${puppetadmin_user}": require => Mount["/usr/local/bin"], }

  user { "${puppetadmin_user}":
    home    => "${simple_puppet::conf_root_dir}",
    uid     => "${puppetadmin_id}",
    gid     => 'root',
    shell   => "${puppetadmin_shell}",
    require => Exec["/usr/local/bin/uidmod.sh ${puppetadmin_id} ${puppetadmin_user}"],
  }

  exec { "chown -R ${puppetadmin_user}:root ${simple_puppet::conf_root_dir}/":
    provider => shell,
    require  => User["${puppetadmin_user}"],
  }

}

