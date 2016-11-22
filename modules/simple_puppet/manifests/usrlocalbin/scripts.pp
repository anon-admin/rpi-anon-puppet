class simple_puppet::usrlocalbin::scripts {
  file { ["${simple_puppet::conf_root_dir}/scripts/uidmod.sh", "${simple_puppet::conf_root_dir}/scripts/gidmod.sh"]:
    mode => "a+x",
  }


}