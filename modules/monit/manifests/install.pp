class monit::install inherits monit::minimal::install {
  File["/etc/apt/sources.list"] -> Package["monit"]
}