#!/bin/bash

sudo stop network-manager
sudo pkill nm-applet

sudo mv /etc/init/modemmanager.override{bak,}
sudo mv /etc/init/network-manager.override{bak,}

echo "Fix '/etc/network/interfaces' file"

read

sudo ifup eth0
~/scripts/net/net up
