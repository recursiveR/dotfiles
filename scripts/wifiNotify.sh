#!/bin/sh

case $1 in
*)
	SSID=`iwgetid -r`
	ADDR=`hostname -i`
  notify-send "<b>SSID</b>: $SSID
  <b>IP</b>: $ADDR"

	;;
esac
