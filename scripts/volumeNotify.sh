#!/bin/sh

case $1 in
up)
	CURVOL=`amixer get Master |grep % |awk '{print $4}'|sed 's/[^0-9\%]//g'`
	notify-send --urgency=low --hint=int:transient:1 "Volume: $CURVOL"
	;;
down )
	CURVOL=`amixer get Master |grep % |awk '{print $4}'|sed 's/[^0-9\%]//g'`
	notify-send --urgency=low --hint=int:transient:1 "Volume: $CURVOL"
	;;
*)
	notify-send --urgency=low --hint=int:transient:1 "Mute Toggled"
	::
esac
