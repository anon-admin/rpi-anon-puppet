<img src="http://www.raspberrypi.org/wp-content/uploads/2012/03/Raspi_Colour_R.png" width="90" />

# rpi-anon-puppet

## Before starting

Firstly, I m doing this only for the proof (and also because I'm fed up about ads, (google) tracking, ...). In any case for not legal things, any question to do so will be forget all about and remove if present in wiki or issues.

DO NOT HESITATE to initiate/complete a wiki page with any of your questions. DO NOT HESITATE to create issues.

If it does not break architecture, i will try to reply/correct.

## Overview

Set of puppet manifests to deploy complete anonymizing solution.

To be used using "puppet apply" inside a node.

Current configuration is on Raspberry2 (slimmed jessie raspbian) with 2 ethernet adapters and an external hard drive (br0/dhcp/192.168.1.2 and br1/static/10.1.0.1).
Nodes are deployed using lxc. Network is bridged on both interfaces.

Barebone contains itself a puppet with some deploying utilities (modules : puppet, lxc, rpi_anon_puppet, ...).

bind9 for local domain resolving, then forwarded on tor dns.

iptables rules are needed to reroute correctly packets ; using nodes on differents raspberry avoid using those rules.

## Install

Three configuration (manifests) : tor, i2p and front

"tor" is responsible of a tor node deploying, plus pdnsd. e2guardian (for 80 output accept) can/will be added.

"i2p" is a simple i2p on oracle jdk 8.

"front" is for public access on private network. dnsmasq, privoxy, polipo (no dns leak thanks to isolation), ntpd and nginx acting as proxy.

Configurations files are done to interconnect tools, some iprules are also used.

# Update

Today, keep in touch using git pull

