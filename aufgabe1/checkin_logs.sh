#!/bin/sh

cd /root/configs
git pull
cp /var/log/* logs/ -r
git add logs/*
git commit -am "add daily logs"
git push
