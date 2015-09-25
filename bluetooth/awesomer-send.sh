#!/bin/bash

CONFIG="$HOME/.config/bluetooth.conf"
source "$CONFIG"

bluetooth-sendto --device="${DEVICE_ADDR}" "$@"
