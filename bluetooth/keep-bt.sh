#!/bin/bash

# This script is a very hacky way for keeping a laptop with bad bluetooth
# signal connected to a pair of headphones.

# Headphones' address
BADDR=38:18:4C:BE:49:FC

reconnect() {
	echo "Reconnecting @ $(date) ..."
	~/scripts/bluetooth/connect_bluetooth_headphones.sh
	# bluetoothctl disconnect "$BADDR"
	# bluetoothctl connect "$BADDR"
	echo "Reconnection done."
}

~/scripts/bluetooth/play_silence.sh &

FLAG_FILE=/tmp/bluetooth-disable

while true
do
	output=$( hcitool rssi $BADDR 2>&1 )
	if [[ -e "$FLAG_FILE" ]]
	then
		SLEEP_DURATION=10s
	else
		SLEEP_DURATION=1s
		if [[ $? -ne 0 ]]
		then
			reconnect
		else
			if echo "$output" | grep "Not connected"
			then
				reconnect
			fi
		fi
	fi
	sleep "$SLEEP_DURATION" || echo "Sleep was interrupted."
done
