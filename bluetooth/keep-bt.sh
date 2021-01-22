#!/bin/bash

BADDR=38:18:4C:BE:49:FC

reconnect() {
	echo "Reconnecting @ $(date) ..."
	bluetoothctl disconnect "$BADDR"
	bluetoothctl connect "$BADDR"
	echo "Reconnection done."
}

while true
do
	output=$( hcitool rssi $BADDR 2>&1 )
	if [[ $? -ne 0 ]]
	then
		reconnect
	else
		if echo "$output" | grep "Not connected"
		then
			reconnect
		fi
	fi
	sleep 1s || echo "Sleep was interrupted."
done
