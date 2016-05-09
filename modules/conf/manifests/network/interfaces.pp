class conf::network::interfaces {

  contain conf::network::install::bridge_latest
  contain conf::network::config::interfaces

}