#!/bin/bash

DATE=`date '+%R %Z%n%A, %B %d, %Y%nDay %j, Week %W'`
CAL=`cal -3 -m`
notify-send "$DATE"
