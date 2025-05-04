#!/bin/bash

IP=127.0.0.1
PORT=80
LOG_FILE=~/log.txt
STATUS_FILE=status.txt

NC=$( nc -zv $IP $PORT 2>&1 )
echo $NC

if [[ $NC == *failed* ]]; then
	echo " $(date '+%b %d %T') port_check IP $IP Port $PORT is not available" >> $LOG_FILE
	echo "$PORT false" > $STATUS_FILE

elif [[ $NC == *succee* && -s $STATUS_FILE ]]; then
	echo " $(date '+%b %d %T') port_check IP $IP Port $PORT is available again" >> $LOG_FILE
	echo -n > $STATUS_FILE
fi
