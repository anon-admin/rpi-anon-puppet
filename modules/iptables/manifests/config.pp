class iptables::config inherits conf::network::config::iptables {
  contain iptables
  
  $is_lxc_box = $iptables::is_lxc_box
  $domain_privaten = $iptables::domain_privaten
  $localdomain = $iptables::localdomain
  $provider_domain_name = $iptables::provider_domain_name
  $provider_domain = $iptables::provider_domain
  $prodiver_dns_ip = $iptables::prodiver_dns_ip
  $prodiver_dns_port = $iptables::prodiver_dns_port
  $routeur_ip = $iptables::prodiver_dns_port
  $routeur_private_ip = $iptables::prodiver_dns_port
  $localn = $iptables::localn
  $privaten = $iptables::privaten
  $front_ip = $iptables::front_ip
  $tor_ip = $iptables::tor_ip
  $tor_private_ip = $iptables::tor_private_ip
  $i2p_ip = $iptables::i2p_ip
  $i2p_private_ip = $iptables::i2p_private_ip

  include userids

  $tor_id = $userids::tor_id
  $tor_user = $userids::tor_user

  $pdnsd_id = $userids::pdnsd_id
  $pdnsd_user = $userids::pdnsd_user
  
  $privoxy_id = $userids::privoxy_id
  $privoxy_user = $userids::privoxy_user

  $i2p_id = $userids::i2p_id
  $i2p_user = $userids::i2p_user

    
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