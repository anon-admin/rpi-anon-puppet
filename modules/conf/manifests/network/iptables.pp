class conf::network::iptables inherits conf::network::install::iptables {

  contain conf::network::config::iptables
  contain conf::network::install::iptables_latest

}