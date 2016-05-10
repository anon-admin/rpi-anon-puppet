class monit::install inherits monit::minimal::install {
  
  include conf::install::apt
  
  File["/etc/apt/sources.list"] -> Package["monit"]
}