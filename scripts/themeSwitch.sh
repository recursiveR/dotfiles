#!/bin/sh

case $1 in
empire)
	xrdb -merge .Xresources.d/empire_theme
	feh --bg-scale ~/.wallpapers/sw/empire.jpg
	polybar -r xbar &
	i3 reload &
	;;
rebellion)
	xrdb -merge .Xresources.d/rebel_theme
	feh --bg-scale ~/.wallpapers/sw/rebellion.jpeg
	polybar -r xbar &
	i3 reload &
	;;
rebel)
	xrdb -merge .Xresources.d/rebel_theme
	feh --bg-scale ~/.wallpapers/sw/rebellion.jpeg
	polybar -r xbar &
	i3 reload &
	;;
light)
	FILE=`find ~/.wallpapers/light/ -type f | shuf -n 1`
	feh --bg-scale $FILE
	xrdb -merge .Xresources.d/light_theme
	polybar -r xbar &
	i3 reload &
	;;
dark)
	FILE=`find ~/.wallpapers/dark/ -type f | shuf -n 1`
	feh --bg-scale $FILE
	xrdb -merge .Xresources.d/dark_theme
	polybar -r xbar &
	i3 reload &
	;;
*)
	xrdb -merge .Xresources
	polybar -r xbar &
	i3 reload &
	;;
esac

pkill -o polybar
notify-send --urgency=low 'Theme: '$1
