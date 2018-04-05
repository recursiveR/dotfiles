#!/bin/sh

case $1 in 
up)
	amixer set Master on
	amixer set Master 10%+
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9\%]//g'`
	notify-send "<b>Volume</b>: $CURVOL"
	;;
down)
	amixer set Master on
	amixer set Master 10%-
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9\%]//g'`
	notify-send "<b>Volume</b>: $CURVOL"
	;;
mute)
	amixer set Master toggle | grep % | awk '{print $6}' | sed 's/[^a-z\%]//g' | {
		read -r status

	if [ "$status" = off ]; then
		notify-send "<b>Volume</b>: Muted"
	fi
	if [ "$status" = on ]; then
		CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9\%]//g'`
		notify-send "<b>Volume</b>: $CURVOL"
	fi
	}
	;;
esac
