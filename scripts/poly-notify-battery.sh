#!/bin/sh

TMPDIR='/tmp/polybar-notify'
TIMERRESET="$TMPDIR/timer-reset"
NOTIFICATIONSFILE="$TMPDIR/notifications"

acpi -b | awk -F'[,:%]' '{print $2, $3, $5, $6}' | {
	read -r status capacity hour minute

	echo "Battery: $capacity%  ·  $hour:$minute" >> $NOTIFICATIONSFILE
	echo "1" > $TIMERRESET
}
