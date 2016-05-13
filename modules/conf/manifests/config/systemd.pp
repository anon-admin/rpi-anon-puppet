class conf::config::systemd inherits conf::install::systemd {
  Package["systemd"] {
    ensure => latest, }

  exec { "/bin/systemctl daemon-reload":
    cwd         => "/lib/systemd",
    refreshonly => true,
  }
  Package["systemd"] -> Exec["/bin/systemctl daemon-reload"]
  Exec["/bin/systemctl daemon-reload"] -> Service<| |> 

}
