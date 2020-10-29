#!/bin/sh

nmcli connection down Rampart
sleep 1s
nmcli connection up Rampart
