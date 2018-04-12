#!/bin/sh

volEcho() {
	CURVOL=`amixer get Master | grep % | awk '{print $4}' | sed 's/[^0-9]//g'`
	ROUNDVOL=$((CURVOL/10 + 1))
	i=1
	while [ "$i" -lt 12 ]
	do
		if [ $i == $ROUNDVOL ]
		then
			echo -n "●"
		else
			echo -n "―"
		fi
		i=$((i+1))
	done
}

volIncrease() {
	while true; do
		echo "%{c}%{F#bbbbff} %{F-} $(volEcho)"
		sleep 3
		pkill -o lemonbar
		break
	done
}

volDecrease() {
	while true; do
		echo "%{c}%{F#bbbbff} %{F-} $(volEcho)"
		sleep 3
		pkill -o lemonbar
		break
	done
}

volMute() {
	while true; do
		echo "%{c}%{F#bbbbff} %{F-} Mute"
		sleep 3
		pkill -o lemonbar
		break
	done
}

notifyUp() {
	volIncrease | \
		lemonbar -d -p \
		-g 110x30+1326+4 \
		-f "Hack:pixelsize=10" \
		-f "FontAwesome:size=9" \
		-B \#252525 \
		-F \#eeeeee
}

notifyDown() {
	volDecrease | \
		lemonbar -d -p \
		-g 110x30+1326+4 \
		-f "Hack:pixelsize=10" \
		-f "FontAwesome:size=9" \
		-B \#252525 \
		-F \#eeeeee
}

notifyMute() {
	volMute | \
		lemonbar -d -p \
		-g 110x30+1326+4 \
		-f "Hack:pixelsize=10" \
		-f "FontAwesome:size=9" \
		-B \#252525 \
		-F \#eeeeee
}
case $1 in 
up)
	amixer set Master on
	amixer set Master 10%+
	notifyUp
	;;
down)
	amixer set Master on
	amixer set Master 10%-
	notifyDown
	;;
mute)
	amixer set Master toggle | grep % | awk '{print $6}' | sed 's/[^a-z\%]//g' | {
		read -r status

	if [ "$status" = off ]; then
		notifyMute
	fi
	if [ "$status" = on ]; then
		notifyUp
	fi
	}
	;;
esac
