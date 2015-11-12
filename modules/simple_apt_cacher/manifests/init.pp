# Class: simple_apt_cacher
#
# This module manages simple_apt_cacher
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class simple_apt_cacher inherits simple_apt_cacher::install {
  include userids
  $acng_user = $userids::acng_user
  $acng_id = $userids::acng_id

  file { "/etc/default/apt-cacher-ng": }


}
