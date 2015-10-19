
class userids::conf::proxygroup {
  $proxy_id = 13
  $proxy_group = "proxy"

  group { "${proxy_group}": gid => $proxy_id, }

}