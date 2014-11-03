#!/bin/sh
burnP6 &
`sleep 3m && killall burnP6` &

while [ `pgrep burnP6 &>/dev/null` ]
do
	echo ""
	date +%M/%d/%m/%Y
	sensors |   grep C | awk -F'[:|(]' '{print $2}'  | grep -o '[0-9]*\.[0-9]' 
	sleep 1m
done
