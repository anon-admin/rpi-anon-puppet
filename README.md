<img src="http://www.raspberrypi.org/wp-content/uploads/2012/03/Raspi_Colour_R.png" width="90" />

# rpi-anon-puppet

## Overview

Set of puppet manifests to deploy complete anonymizing solution.
To be used using "puppet apply" inside a node.

Current configuration is on Raspberry2 (slimmed jessie raspbian) with 2 ethernet adapters and an external hard drive.
Nodes are deployed using lxc. Network is bridged on both interfaces.

Barebone contains itself a puppet with some deploying utilities (modules : puppet, lxc, rpi_annon_puppet, ...).
bind9 for local domain resolving, then forwarded on tor dns.
iptables rules are needed to reroute correctly packets ; using nodes on differents raspberry avoid using those rules.

## Install

Three configuration (manifests) : tor, i2p and front

"tor" is responsible of a tor node deploying, plus pdnsd. Retroshare and e2guardian (for 80 output accept) can/will be added.

"i2p" is a simple i2p on oracle jdk 8.

"front" is for public acces on private network. dnsmasq, privoxy, polipo (no dns leak thanks to isolation), ntpd and nginx acting as proxy.

Configurations files are done to interconnect tools, some iprules are also used.

# Update

Today, keep in touch using git pull

