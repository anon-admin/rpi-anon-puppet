# Class: polipo
#
# This module manages polipo
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class polipo ($tor_ip = $polipo::params::tor_ip, $tor_port = $polipo::params::tor_port) inherits polipo::params {
  contain polipo::install
  contain polipo::config
  contain polipo::service
}
