#!/bin/sh

TMPDIR='/tmp/polybar-notify'
TIMERRESET="$TMPDIR/timer-reset"
NOTIFICATIONSFILE="$TMPDIR/notifications"

bspc wm -g | awk -F'[:]' '{print $2, $3, $4, $5, $6}' | {
	read -r desk1 desk2 desk3 desk4 desk5

	OUTPUT="%{T3} %{T-}  "
	for i in {1..5}; do
		DESKSTATUS="$(eval "echo \$desk$i")"
		DESKSTATUS="${DESKSTATUS:0:1}"

		if [ $DESKSTATUS = "O" ] || [ $DESKSTATUS = "F" ]; then
			OUTPUT="$OUTPUT  "
		
		elif [ $DESKSTATUS = "o" ]; then
			OUTPUT="$OUTPUT  "

		elif [ $DESKSTATUS = "f" ]; then
			OUTPUT="$OUTPUT  "
		fi
	done

	OUTPUT="$OUTPUT"

	echo "$OUTPUT" >> $NOTIFICATIONSFILE
	echo "1" > $TIMERRESET

}
