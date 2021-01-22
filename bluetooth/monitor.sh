#!/bin/sh

# Sony headphones
BADDR=38:18:4C:BE:49:FC
hcitool rssi $BADDR
hcitool lq $BADDR
