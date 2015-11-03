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
  case $lsbdistcodename {
    "wheezy" : { contain conf::sysvinit }
    default  : { contain conf::systemd }
  }
  contain conf::cron
  contain conf::apt
  contain conf::wget

}

