#!/bin/bash

createfile() {
FILENAME=$1

if [[ -f $FILENAME ]]; then
	return 2
fi

touch $FILENAME 2> /dev/null
if [[ $? -eq 0 ]]; then
	return 0
else
	return 1

fi
}
