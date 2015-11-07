class i2p::clean inherits i2p {
  tidy { "/var/log/i2p":
    recurse => true,
    backup  => false,
    age     => "4w",
    require => Mount["/var/log/i2p"],
  }

}
