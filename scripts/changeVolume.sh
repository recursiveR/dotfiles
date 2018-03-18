#!/bin/sh

case $1 in 
up)
	amixer set Master on
	amixer set Master 10%+
	;;
down)
	amixer set Master on
	amixer set Master 10%-
	;;
*)
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9\%]//g'`
	notify-send "<b>Volume</b>: $CURVOL"
	;;
esac
