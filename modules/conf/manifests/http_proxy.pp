class conf::http_proxy ($http_proxy_ip, $http_proxy_port, $https_proxy_ip = "", $https_proxy_port = "") {
  file { "/etc/profile.d/proxy.sh":
    mode   => 644,
    ensure => present,
  }

  File["/etc/profile.d/proxy.sh"] -> Exec["http_proxy in /etc/profile.d/proxy.sh"]

  exec { "http_proxy in /etc/profile.d/proxy.sh":
    command  => "/bin/echo \"export http_proxy=http://${http_proxy_ip}:${http_proxy_port}\" >>/etc/profile.d/proxy.sh",
    provider => shell,
    cwd      => '/tmp',
    unless   => "/bin/grep '^export http_proxy=http://' /etc/profile.d/proxy.sh",
  }

  exec { "good http_proxy in /etc/profile.d/proxy.sh":
    command  => "/bin/sed -i \"s#http_proxy=http://.*#http_proxy=http://${http_proxy_ip}:${http_proxy_port}#\" /etc/profile.d/proxy.sh",
    provider => shell,
    cwd      => '/tmp',
    unless   => "/bin/grep \"http_proxy=http://${http_proxy_ip}:${http_proxy_port}\$\" /etc/profile.d/proxy.sh",
    require  => Exec["http_proxy in /etc/profile.d/proxy.sh"],
  }

  if ($https_proxy_ip != "" and $https_proxy_port != "") {
    File["/etc/profile.d/proxy.sh"] -> Exec["https_proxy in /etc/profile.d/proxy.sh"]

    exec { "https_proxy in /etc/profile.d/proxy.sh":
      command  => "/bin/echo \"export https_proxy=https://${https_proxy_ip}:${https_proxy_port}\" >>/etc/profile.d/proxy.sh",
      provider => shell,
      cwd      => '/tmp',
      unless   => "/bin/grep '^export https_proxy=https://' /etc/profile.d/proxy.sh",
    }

    exec { "good http_proxys in /etc/profile.d/proxy.sh":
      command  => "/bin/sed -i \"s#https_proxy=https://.*#https_proxy=https://${https_proxy_ip}:${https_proxy_port}#\" /etc/profile.d/proxy.sh",
      provider => shell,
      cwd      => '/tmp',
      unless   => "/bin/grep \"https_proxy=https://${https_proxy_ip}:${https_proxy_port}\$\" /etc/profile.d/proxy.sh",
      require  => Exec["https_proxy in /etc/profile.d/proxy.sh"],
    }
  }

}