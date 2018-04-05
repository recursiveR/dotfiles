#!/bin/sh
acpi -b | awk -F'[,:%]' '{print $2, $3, $5, $6}' | {
	read -r status capacity hour minute

echo %{c} Battery: $capacity% %{c} | \
lemonbar -d -p \
	-g 150x50+1285+5 \
	-f "Noto Sans" \
	-B \#303030 \
	-F \#eeeeee

}
