#!/bin/bash

BACKGROUND='#252525'
FOREGROUND='#CCCCCC'
ACCENT='#0b76de'
DISABLED='#666666'
DELAY=2

clock() {
	DATETIME=$(date '+%R %Z  ·  %A, %B %d')
	echo -n "$DATETIME"
}

clockNotify() {
	while true; do
		echo "%{c}$(clock)"
		sleep $DELAY
	done
}

# Kill any already running lemonClock processes
PID=`pgrep -n lemonClock.sh`
while [ $PID != `pgrep -o lemonClock.sh` ]; do
	pkill -o lemonClock.sh
done

clockNotify | \
	lemonbar -d -p \
	-g 260x28+590+0 \
	-f "Noto Sans:style=bold:size=10" \
	-B $BACKGROUND \
	-F $FOREGROUND \
	-U $ACCENT
