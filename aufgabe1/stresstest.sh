#!/bin/sh
burnP6 &
`sleep 30m && killall burnP6` &

while [ `pgrep burnP6 &>/dev/null` ]
do
	printf "%s %s\n" "`date +%d/%m/%Y\ %H:%M:%S`" "`sensors |   grep C | awk -F'[:|(]' '{print $2}'  | grep -o '[0-9]*\.[0-9]' | cut -f1 | xargs`"
	sleep 3m
done
