class simple_puppet::ignore::yaml($conf_root_dir = $simple_puppet::conf_root_dir) inherits simple_puppet {

  $passwd_hiera_file = "${simple_puppet::hiera_dir}/passwords.yaml"

  include stdlib
  file_line { "gitignore ${conf_root_dir} ${passwd_hiera_file}":
    path => "${conf_root_dir}/.gitignore",
    line => "${passwd_hiera_file}",
  }

  File["${conf_root_dir}/${simple_puppet::hiera_dir}"] -> File_line["gitignore ${conf_root_dir} ${passwd_hiera_file}"]

}
