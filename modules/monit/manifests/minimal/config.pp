class monit::minimal::config inherits monit::minimal::install {

    file { ["/etc/monit/conf.d","/etc/monit/monitrc.d","/etc/monit"]:
      owner => root,
      group => root,
      mode => 555,
      ensure => directory,
      require => Package["monit"],
    }
    
    exec { "/usr/bin/find /etc/monit -name '*~' -delete":
      require => File["/etc/monit"],
    }
    
    

}
