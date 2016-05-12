# Class: sshd
#
# This module manages sshd
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class sshd {
  contain sshd::install
  contain sshd::config
  contain sshd::service
}
