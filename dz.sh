#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="${3:-1}"
HOST="${4:-1}"

#Checking for root
username=`id -nu`
ROOTUSER_NAME=root
if [ "$username" != "$ROOTUSER_NAME" ]
then
	echo "Must be root to run \"`basename $0`\"."
	exit 1
fi

#Cheking paraments
[[ "$PREFIX" = "NOT_SET" ]] && { echo "PREFIX must be passed as first positional argument"; exit 1; }
[[ ! $PREFIX =~ ^(([0-9]+)\.)?[0-9]+$ ]] && { echo "PREFIX must be digits from 1 or like (192.168)"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "INTERFACE must be passed as second positional argument"
    exit 1
fi
[[ ! $SUBNET =~ ^[0-9]+$ ]] && { echo "$SUBNET must be digits from 0"; exit 1; }
[[ ! $HOST =~ ^[0-9]+$ ]] && { echo "$HOST must be digits from 0"; exit 1; }

#Checking SUBNET and HOST
if [[ $# -eq 3 ]];then
	for HOST2 in {0..255}
	do
		echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST2}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST2}" 2> /dev/null
	done
elif [[  $# -eq 4 ]];then
	echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/nul
else
for SUB in {0..255}
do
	for HO in {0..255}
	do
		echo "[*] IP : ${PREFIX}.${SUB}.${HO}"
		arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUB}.${HO}" 2> /dev/null
	done
done
fi
