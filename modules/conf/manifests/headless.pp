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
    "xserver-xorg-video-fbdev",
    "libglade2-0",
    "libutempter0",
    "lxtask",
    "p7zip-full",
    "python-xdg",
    "raspberrypi-artwork",
    "xbitmaps",
    "xterm",
    "lxde",
    "lxde-core",
    "pipanel",
    "raspberrypi-ui-mods",
    "squeak-vm",
    "gnome-desktop3-data",
    "gnome-icon-theme",
    "gnome-icon-theme-symbolic",
    "gnome-menus",
    "gnome-themes-standard",
    "gnome-themes-standard-data",
    "libgnome-desktop-3-10",
    "libgnome-keyring-common",
    "libgnome-keyring0",
    "libgnome-menu-3-0",
    "epiphany-browser",
    "lxappearance-obconf",
    "lxkeymap",
    "lxmenu-data",
    "lxpanel-data",
    "lxsession",
    "alacarte",
    "gir1.2-gmenu-3.0",
    "gksu",
    "libfm4",
    "libgksu2-0",
    "raspberrypi-net-mods",
    "rc-gui",
    "scratch",
    "nuscratch",
    "xserver-xorg-core",
    "xserver-xorg-video-fbturbo"]


  package { $pkgs_to_remove:
    ensure => purged,
    before => Exec["/usr/bin/apt-get -y autoremove"],
    notify => Exec["/usr/bin/apt-get -y autoremove"],
  }

  exec { "/usr/bin/apt-get -y autoremove":
    cwd         => "/tmp",
    refreshonly => true,
    provider    => shell,
    user        => root,
  }
}