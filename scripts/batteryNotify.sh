#!/bin/sh
acpi -b | awk -F'[,:%]' '{print $2, $3, $5, $6}' | {
	read -r status capacity hour minute

	if [ "$status" = Discharging ]; then 
		notify-send --urgency=low "<b>Battery</b>: $capacity%
$hour:$minute remaining"
	fi

	if [ "$status" = Charging ]; then
		notify-send --urgency=low "<b>Battery</b>: $capacity%
$hour:$minute until charged"
	fi
}
