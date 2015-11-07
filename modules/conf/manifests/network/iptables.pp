class conf::network::iptables inherits conf::network::install::iptables {

  contain conf::network::config::iptables

}