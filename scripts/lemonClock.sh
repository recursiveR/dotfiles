#!/bin/bash

BACKGROUND='#252525'
FOREGROUND='#CCCCCC'
ACCENT='#0b76de'
DISABLED='#666666'
DELAY=2

clock() {
	DATETIME=$(date '+%R %Z  %A, %B %d %Y')
	echo -n "$DATETIME"
}

clockNotify() {
	while true; do
		echo "%{c}$(clock)"
		sleep $DELAY
	done
}

clockNotify | \
	lemonbar -d -p \
	-g 270x30+585+0 \
	-f "Roboto Condensed:style=bold:size=10" \
	-B $BACKGROUND \
	-F $FOREGROUND


