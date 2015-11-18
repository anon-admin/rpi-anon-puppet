class iptables::service inherits iptables {
  
  exec { "/sbin/iptables-restore </root/iptables.sav":
    provider => shell,
    cwd => '/tmp',
  }
  File["/root/iptables.sav"] -> Exec["/sbin/iptables-restore </root/iptables.sav"]
  
  cron { "/sbin/iptables-restore </root/iptables.sav": special => reboot, }
  Service[cron] -> Cron["/sbin/iptables-restore </root/iptables.sav"]
  Exec["/sbin/iptables-restore </root/iptables.sav"] -> Cron["/sbin/iptables-restore </root/iptables.sav"]
}