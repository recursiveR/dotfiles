#!/bin/sh

TMPDIR='/tmp/polybar-notify'
TIMERRESET="$TMPDIR/timer-reset"
NOTIFICATIONSFILE="$TMPDIR/notifications"

EXTERNALIP=`curl icanhazip.com`
INTERNALIP=`hostname -i`

echo "External: $EXTERNALIP  ·  Internal: $INTERNALIP" >> $NOTIFICATIONSFILE
echo "1" > $TIMERRESET
