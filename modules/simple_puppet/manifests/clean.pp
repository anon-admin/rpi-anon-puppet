class simple_puppet::clean ($reports_dir = $simple_puppet::reports_dir, $clientbucket_dir = $simple_puppet::clientbucket_dir) 
inherits simple_puppet {
  tidy { ["${clientbucket_dir}", "${reports_dir}"]:
    recurse => true,
    backup  => false,
    age     => "1w",
    type    => 'mtime',
  }

  Tidy["${clientbucket_dir}"] {
    rmdirs => false, }

  Tidy["${reports_dir}"] {
    rmdirs => true, }

}