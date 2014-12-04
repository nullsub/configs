#!/bin/sh

#der cronjob wird jeden Tag um 18:05 ausgeführt. 
#crontab Inhalt:
# 05 18 * * * /root/checkin_logs.sh 

cd /root/configs
git pull
cp /var/log/* logs/ -r
git add logs/*
git commit -am "add daily logs"
git push
