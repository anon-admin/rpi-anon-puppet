class conf::install::apt {
  
  file { "/etc/apt/sources.list": }
  
  package { "apt": }

}