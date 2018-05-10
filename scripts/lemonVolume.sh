#!/bin/sh

# Color variables
BACKGROUND='#252525'
FOREGROUND='#CCCCCC'
ACCENT='#0b76de'
DISABLED='#666666'

# Time to wait before killing notification process
DELAY=1

# Notification labels
UPLABEL=
DOWNLABEL=$UPLABEL
MUTELABEL=

volEcho() {
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9]//g'`
	ROUNDVOL=$((CURVOL/5 + 1))
	i=1
	while [ "$i" -lt 22 ]
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
		VOLSTRING="%{c}$UPLABEL $(volEcho)"
		;;
	decrease)
		VOLSTRING="%{c}$DOWNLABEL $(volEcho)"
		;;
	mute)
		VOLSTRING="%{c}$MUTELABEL $(volEcho)"
		;;
	esac

	PID=`pgrep -n lemonbar`
	echo $VOLSTRING
	sleep $DELAY
	kill $PID
}

volNotify() {
	volChange $1 | \
		lemonbar -d -p \
		-g 300x40+570+430 \
		-f "DejaVu Sans Mono:size=14" \
		-f "FontAwesome:size=16" \
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
