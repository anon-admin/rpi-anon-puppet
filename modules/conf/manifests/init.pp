# Class: conf
#
# This module manages conf
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class conf {

  contain conf::sysvinit
  contain conf::cron
  contain conf::apt
  contain conf::wget

}

