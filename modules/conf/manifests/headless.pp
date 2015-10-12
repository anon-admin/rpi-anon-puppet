class conf::headless {
  $pkgs_to_remove = [
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
    "lxterminal",
    "wolfram-engine",
    "obconf",
    "openbox",
    "raspberrypi-artwork",
    "xarchiver",
    "xinit",
    "xserver-xorg",
    "xserver-xorg-video-fbdev"]

  package { $pkgs_to_remove:
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