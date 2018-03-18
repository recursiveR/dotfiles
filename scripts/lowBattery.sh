#!/bin/sh
acpi -b | awk -F'[,:%]' '{print $2, $3, $5, $6}' | {
	read -r status capacity hour minute

	if [ "$status" = Discharging -a "$capacity" -lt 6 ]; then
		notify-send --urgency=critical "<b>Low Battery</b>
$capacity% - $hour:$minute remaining"
	fi

	if [ "$status" = Discharging -a "$capacity" -lt 4 ]; then
		systemctl suspend
	fi
}
