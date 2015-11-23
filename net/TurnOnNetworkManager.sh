#!/bin/bash

~/scripts/net/net down
sudo ifdown eth0

echo "Fix '/etc/network/interfaces' file, then press Enter."
read

sudo mv /etc/init/modemmanager.override{,bak}
sudo mv /etc/init/network-manager.override{,bak}

sudo start network-manager
SLEEPTIME=5
echo "sleeping ${SLEEPTIME} sec"
sleep "${SLEEPTIME}s"
nm-applet 2> /dev/null & disown


