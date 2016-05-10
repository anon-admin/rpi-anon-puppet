class monit::minimal::service inherits monit::minimal::config {
  
    file { "/etc/default/monit":
      owner => root,
      group => root,
      mode => 444,
      notify => Service["monit"],
    }
    
 
    service { "monit":
    }

    Exec["/usr/bin/find /etc/monit -name '*~' -delete"] -> Service[monit]

}