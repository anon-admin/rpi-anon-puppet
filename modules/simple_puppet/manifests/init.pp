# Class: simple_puppet
#
# This module manages simple_puppet
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class simple_puppet(
  $puppetadmin_user = $simple_puppet::params::puppetadmin_user,
  $puppetadmin_id = $simple_puppet::params::puppetadmin_id,
  $puppetadmin_shell,
  $reports_dir = $simple_puppet::params::reports_dir,
  $clientbucket_dir,
  $manifest) inherits simple_puppet::params {

}







