#!/bin/bash

SELF='polybar-notifications-manager.sh'
TMPDIR='/tmp/polybar-notify'
TIMERRESET="$TMPDIR/timer-reset"
NOTIFICATIONSFILE="$TMPDIR/notifications"

DELAY=5

get_clock() {
	DATETIME=$(date '+%A, %B %d  ·  %R %Z')
	echo "$DATETIME"
}

# Create Directory, Notifications File, and Timer Reset File
mkdir -p $TMPDIR
touch $NOTIFICATIONSFILE
touch $TIMERRESET

# Add Datetime to Notifications File
CURRENTTIME=$(get_clock)
echo $CURRENTTIME > $NOTIFICATIONSFILE

# Start Management Loop
while true; do
	# Check for Timer Reset
	if [ `head -n 1 $TIMERRESET` -eq 1 ]; then
		SECONDS=0
		echo 0 > $TIMERRESET
		sed -i '1 d' $NOTIFICATIONSFILE
	fi

	if [ $SECONDS -ge $DELAY ]; then
		# If the current notification is the last notification, add a new time line
		if [ `cat $NOTIFICATIONSFILE | wc -l` -le 1 ]; then
			echo "Notifications Low"
			CURRENTTIME=$(get_clock)
			echo $CURRENTTIME >> $NOTIFICATIONSFILE
		fi

		# Set Timer Reset Variable
		echo 1 > $TIMERRESET
	fi
done
