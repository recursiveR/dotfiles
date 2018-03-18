#!/bin/sh

case $1 in
*)
	BACKLIGHT=`cat /sys/class/backlight/intel_backlight/brightness`
	MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
	let PERCENT=$BACKLIGHT*100/$MAX
	notify-send --urgency=low "<b>Backlight</b>: $PERCENT%"
	;;
esac
