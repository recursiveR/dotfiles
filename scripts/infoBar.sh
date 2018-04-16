#!/bin/bash

clock() {
	DATETIME=$(date '+%R %Z  %A, %B %d %Y')
	echo -n "$DATETIME"
}

while true; do
	echo "%{c}$(clock)"
	sleep 1
done
