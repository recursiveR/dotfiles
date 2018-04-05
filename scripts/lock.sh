lock() {
	background=25252500
	foreground=ccccccff
	accent=0b76deff
	warning=e25147ff
	i3lock \
		-t \
		--blur=1.0 \
		--force-clock \
		--timepos="x+100:h-100" \
		--timestr="%H:%M %Z" \
		--timecolor=$foreground \
		--datepos="tx:ty+20" \
		--datecolor=$foreground \
		--indpos="x+240:h-110" \
		--radius=20 --ring-width=3 \
		--line-uses-inside \
		--keyhlcolor=$accent \
		--bshlcolor=$warning \
		--separatorcolor=$background \
		--ringcolor=$foreground \
		--insidecolor=$background \
		--veriftext="" \
		--ringvercolor=$accent \
		--insidevercolor=$foreground \
		--wrongtext="" \
		--ringwrongcolor=$foreground \
		--insidewrongcolor=$warning \
		--noinputtext=""
}

lock
