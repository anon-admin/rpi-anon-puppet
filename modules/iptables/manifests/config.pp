class iptables::config inherits conf::network::config::iptables {
  contain iptables::params
  
  $is_lxc_box = $iptables::params::is_lxc_box
  
  if ($is_lxc_box) {
    $ids = split($hostname, '_')
    $boxname = $ids[1]
    
    File["/root/iptables.sav"] { 
      content => template("iptables/${boxname}.erb"),
    }
  } else {
    File["/root/iptables.sav"] { 
      content => template("iptables/${hostname}.erb"),
    }
  }
}