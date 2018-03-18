#!/bin/sh
connmanctl state | grep State | awk '{print $3}' | {
	read -r status

	if [ "$status" = online ]; then
		connmanctl disable wifi
		notify-send --urgency=low "<b>Wifi</b>: Disabled"
	fi

	if [ "$status" = idle ]; then
		connmanctl enable wifi
		notify-send --urgency=low "<b>Wifi</b>: Enabled"
	fi
}
