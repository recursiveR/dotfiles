#!/bin/sh

pkill -o polybar
case $1 in
empire)
	xrdb -merge ~/.Xresources.d/empire_theme
	feh --bg-scale ~/.wallpapers/sw/empire.jpg
	polybar -r xbar &
	;;
rebellion)
	xrdb -merge ~/.Xresources.d/rebel_theme
	feh --bg-scale ~/.wallpapers/sw/rebellion.jpeg
	polybar -r xbar &
	;;
rebel)
	xrdb -merge ~/.Xresources.d/rebel_theme
	feh --bg-scale ~/.wallpapers/sw/rebellion.jpeg
	polybar -r xbar &
	;;
light)
	FILE=`find ~/.wallpapers/light/ -type f | shuf -n 1`
	feh --bg-scale $FILE
	xrdb -merge ~/.Xresources.d/light_theme
	polybar -r xbar &
	;;
dark)
	FILE=`find ~/.wallpapers/dark/ -type f | shuf -n 1`
	feh --bg-scale $FILE
	xrdb -merge ~/.Xresources.d/dark_theme
	polybar -r xbar &
	;;
*)
	xrdb -merge .Xresources
	polybar -r xbar &
	;;
esac

notify-send --urgency=low 'Theme: '$1
