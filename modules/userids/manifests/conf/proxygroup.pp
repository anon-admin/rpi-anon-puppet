
class userids::conf::proxygroup {
  $proxy_id = 13
  $proxy_group = "proxy"

  exec { "/usr/local/bin/gidmod.sh ${proxy_id} ${proxy_group}": require => Mount["/usr/local/bin"], }

  group { "${proxy_group}": gid => $proxy_id, }

}