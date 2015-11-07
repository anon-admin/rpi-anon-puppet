class i2p::config inherits i2p {

  contain i2p::mounts
  include i2p::user::definition

  Package[
    "i2p", "i2p-keyring"] {
    ensure  => latest,
    require => Exec["/usr/bin/apt-get update"],
  }
    
  #content => template("i2p/my.cnf.erb"),
  File[
    "/etc/i2p/wrapper.config",
    "${i2p_home}/i2p-config/clients.config",
    "${i2p_home}/i2p-config/i2ptunnel.config"] {
    notify => Service["i2p"],
  }


}
