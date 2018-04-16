#! /bin/sh
#
# Example panel for lemonbar

COLOR_DEFAULT_FG="#a7a5a5"
COLOR_DEFAULT_BG="#333232"
COLOR_MONITOR_FG="#8dbcdf"
COLOR_MONITOR_BG="#333232"
COLOR_FOCUSED_MONITOR_FG="#b1d0e8"
COLOR_FOCUSED_MONITOR_BG="#144b6c"
COLOR_FREE_FG="#737171"
COLOR_FREE_BG="#333232"
COLOR_FOCUSED_FREE_FG="#000000"
COLOR_FOCUSED_FREE_BG="#504e4e"
COLOR_OCCUPIED_FG="#a7a5a5"
COLOR_OCCUPIED_BG="#333232"
COLOR_FOCUSED_OCCUPIED_FG="#d6d3d2"
COLOR_FOCUSED_OCCUPIED_BG="#504e4e"
COLOR_URGENT_FG="#f15d66"
COLOR_URGENT_BG="#333232"
COLOR_FOCUSED_URGENT_FG="#501d1f"
COLOR_FOCUSED_URGENT_BG="#d5443e"
COLOR_STATE_FG="#89b09c"
COLOR_STATE_BG="#333232"
COLOR_TITLE_FG="#a8a2c0"
COLOR_TITLE_BG="#333232"
COLOR_SYS_FG="#b1a57d"
COLOR_SYS_BG="#333232"

num_mon=$(bspc query -M | wc -l)

while read -r line ; do
	case $line in
		S*)
			# clock output
			sys="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}"
			;;
		T*)
			# xtitle output
			title="%{F$COLOR_TITLE_FG}%{B$COLOR_TITLE_BG} ${line#?} %{B-}%{F-}"
			;;
		W*)
			# bspwm's state
			wm=
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ] ; do
				item=$1
				name=${item#?}
				case $item in
					[mM]*)
						case $item in
							m*)
								# monitor
								FG=$COLOR_MONITOR_FG
								BG=$COLOR_MONITOR_BG
								on_focused_monitor=
								;;
							M*)
								# focused monitor
								FG=$COLOR_FOCUSED_MONITOR_FG
								BG=$COLOR_FOCUSED_MONITOR_BG
								on_focused_monitor=1
								;;
						esac
						[ $num_mon -lt 2 ] && shift && continue
						wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
						;;
					[fFoOuU]*)
						case $item in
							f*)
								# free desktop
								FG=$COLOR_FREE_FG
								BG=$COLOR_FREE_BG
								UL=$BG
								;;
							F*)
								if [ "$on_focused_monitor" ] ; then
									# focused free desktop
									FG=$COLOR_FOCUSED_FREE_FG
									BG=$COLOR_FOCUSED_FREE_BG
									UL=$BG
								else
									# active free desktop
									FG=$COLOR_FREE_FG
									BG=$COLOR_FREE_BG
									UL=$COLOR_FOCUSED_FREE_BG
								fi
								;;
							o*)
								# occupied desktop
								FG=$COLOR_OCCUPIED_FG
								BG=$COLOR_OCCUPIED_BG
								UL=$BG
								;;
							O*)
								if [ "$on_focused_monitor" ] ; then
									# focused occupied desktop
									FG=$COLOR_FOCUSED_OCCUPIED_FG
									BG=$COLOR_FOCUSED_OCCUPIED_BG
									UL=$BG
								else
									# active occupied desktop
									FG=$COLOR_OCCUPIED_FG
									BG=$COLOR_OCCUPIED_BG
									UL=$COLOR_FOCUSED_OCCUPIED_BG
								fi
								;;
							u*)
								# urgent desktop
								FG=$COLOR_URGENT_FG
								BG=$COLOR_URGENT_BG
								UL=$BG
								;;
							U*)
								if [ "$on_focused_monitor" ] ; then
									# focused urgent desktop
									FG=$COLOR_FOCUSED_URGENT_FG
									BG=$COLOR_FOCUSED_URGENT_BG
									UL=$BG
								else
									# active urgent desktop
									FG=$COLOR_URGENT_FG
									BG=$COLOR_URGENT_BG
									UL=$COLOR_FOCUSED_URGENT_BG
								fi
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B-}%{F-}%{-u}"
						;;
					[LTG]*)
						# layout, state and flags
						wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG} ${name} %{B-}%{F-}"
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{l}${wm}%{c}${title}%{r}${sys}"
done
