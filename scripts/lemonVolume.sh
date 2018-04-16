#!/bin/sh

BACKGROUND='#252525'
FOREGROUND='#CCCCCC'
ACCENT='#0b76de'
DISABLED='#666666'
DELAY=1

volEcho() {
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9]//g'`
	ROUNDVOL=$((CURVOL/10 + 1))
	i=1
	while [ "$i" -lt 12 ]
	do
		if [ $i == $ROUNDVOL ]
		then
			echo -n "┃"
		else
			if [ $i -lt $ROUNDVOL ]
			then
				echo -n "%{F$ACCENT}━%{F-}"
			else
				echo -n "%{F$DISABLED}━%{F-}"
			fi
		fi
		i=$((i+1))
	done
}

volChange() {
	case $1 in
	increase)
		VOLSTRING="%{c}  $(volEcho)"
		;;
	decrease)
		VOLSTRING="%{c}  $(volEcho)"
		;;
	mute)
		VOLSTRING="%{c}Mute"
		;;
	esac

	echo $VOLSTRING
	sleep $DELAY
	pkill -o lemonbar
}

volNotify() {
	volChange $1 | \
		lemonbar -d -p \
		-g 140x30+1296+4 \
		-f "DejaVu Sans Mono:size=10" \
		-f "FontAwesome:size=12" \
		-B $BACKGROUND \
		-F $FOREGROUND
}

case $1 in 
up)
	amixer set Master on
	amixer set Master 10%+
	volNotify "increase"
	;;
down)
	amixer set Master on
	amixer set Master 10%-
	volNotify "decrease"
	;;
mute)
	amixer set Master toggle | grep % | awk '{print $6}' | sed 's/[^a-z\%]//g' | {
		read -r status

		if [ "$status" = off ]; then
			volNotify "mute"
		fi
		if [ "$status" = on ]; then
			volNotify "increase"
		fi
	}
	;;
esac
