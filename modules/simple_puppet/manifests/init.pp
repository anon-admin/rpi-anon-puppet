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
  $puppetadmin_shell,
  $reports_dir,
  $clientbucket_dir,
  $manifest) {

  include userids
  $puppetadmin_user = $userids::puppetadmin_user
  $puppetadmin_id = $userids::puppetadmin_id
}







