#!/bin/sh

BACKGROUND='#252525'
FOREGROUND='#CCCCCC'
ACCENT='#0b76de'
DISABLED='#666666'
DELAY=1

SCREEN=/sys/class/backlight/intel_backlight
KEYBOARD=/sys/class/leds/smc\:\:kbd_backlight

blEcho() {
	case $1 in
	screen)
		LEVEL=`cat $SCREEN/brightness`
		MAX=`cat $SCREEN/max_brightness`
		;;
	keyboard)
		LEVEL=`cat $KEYBOARD/brightness`
		MAX=`cat $KEYBOARD/max_brightness`
		;;
	esac
	let BRIGHTNESS=$LEVEL*100/$MAX/10
	i=0
	while [ "$i" -lt 11 ]
	do
		if [ $i == $BRIGHTNESS ]
		then
			echo -n "┃"
		else
			if [ $i -lt $BRIGHTNESS ]
			then
				echo -n "%{F$ACCENT}━%{F-}"
			else
				echo -n "%{F$DISABLED}━%{F-}"
			fi
		fi
		i=$((i+1))
	done
}

blChange() {
	case $1 in
	screen)
		ICON=
		;;
	keyboard)
		ICON=
		;;
	esac

	PID=`pgrep -n lemonbar`
	echo "%{c}$ICON  $(blEcho $1)"
	sleep $DELAY
	kill $PID
}

blNotify() {
	blChange $1 | \
		lemonbar -d -p \
		-g 140x28+1296+4 \
		-f "Roboto Condensed:style=bold:size=10" \
		-f "DejaVu Sans Mono:size=10" \
		-f "FontAwesome:size=12" \
		-B $BACKGROUND \
		-F $FOREGROUND
}

case $1 in
screen)
	case $2 in 
	-inc)
		xbacklight -inc $3
		;;
	-dec)
		xbacklight -dec $3
		;;
	-set)
		xbacklight -set $3
		;;
	esac
	blNotify screen
	;;
kbd)
	case $2 in
	-inc)
		xbacklight -ctrl smc::kbd_backlight -inc $3
		;;
	-dec)
		xbacklight -ctrl smc::kbd_backlight -dec $3
		;;
	-set)
		xbacklight -ctrl smc::kbd_backlight -set $3
		;;
	esac
	blNotify keyboard
	;;
*)
	blNotify screen
	blNotify keyboard
	;;
esac
