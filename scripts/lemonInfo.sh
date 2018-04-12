#!/bin/sh

volEcho() {
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9\%]//g'`
	echo -n "$CURVOL"
}

lemonLoop() {
	while true; do
		echo "%{c}%{F#bbbbff}Volume:%{F-} $(volEcho)"
		sleep 3
		pkill -o lemonbar
		break
	done
}

lemonNotify() {
	lemonLoop | \
		lemonbar -d -p \
		-g 240x40+1196+5 \
		-f "Hack:size=10" \
		   "FontAwesome:size=10" \
		-B \#0b76de \
		-F \#eeeeee
}

case $1 in 
up)
	amixer set Master on
	amixer set Master 10%+
	lemonNotify
	;;
down)
	amixer set Master on
	amixer set Master 10%-
	lemonNotify
	;;
mute)
	amixer set Master toggle | grep % | awk '{print $6}' | sed 's/[^a-z\%]//g' | {
		read -r status

	if [ "$status" = off ]; then
		notify-send "<b>Volume</b>: Muted"
	fi
	if [ "$status" = on ]; then
		lemonNotify
	fi
	}
	;;
esac
