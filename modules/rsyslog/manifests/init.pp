# Class: rsyslog
#
# This module manages rsyslog
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class rsyslog inherits rsyslog::config {
  contain rsyslog::logrotate::rsyslog
}
