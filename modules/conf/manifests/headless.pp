class conf::headless {
  $pkgs_to_remove1 = [
    "desktop-base",
    "lightdm",
    "lxappearance",
    "lxde-common",
    "lxde-icon-theme",
    "lxinput",
    "lxpanel",
    "lxpolkit",
    "lxrandr",
    "lxsession-edit",
    "lxshortcut",
    "lxtask",
    "lxterminal"]

  $pkgs_to_remove2 = ["wolfram-engine"]

  $pkgs_to_remove3 = ["obconf", "openbox", "raspberrypi-artwork", "xarchiver", "xinit", "xserver-xorg", "xserver-xorg-video-fbdev"]

  package { $pkgs_to_remove1:
    ensure => purged,
    before => Package[$pkgs_to_remove2],
    notify => Exec["/usr/bin/apt-get -y auto-remove"],
  }

  package { $pkgs_to_remove2:
    ensure => purged,
    before => Package[$pkgs_to_remove3],
    notify => Exec["/usr/bin/apt-get -y auto-remove"],
  }

  package { $pkgs_to_remove3:
    ensure => purged,
    before => Exec["/usr/bin/apt-get -y auto-remove"],
    notify => Exec["/usr/bin/apt-get -y auto-remove"],
  }

  exec { "/usr/bin/apt-get -y auto-remove":
    cwd         => "/tmp",
    refreshonly => true,
    provider    => shell,
    user        => root,
  }
}