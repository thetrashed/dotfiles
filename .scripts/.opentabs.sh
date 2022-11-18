#!/bin/bash

for i in $(cat $HOME/.open_tabs.txt); do
	if [[ "$(pgrep firefox)" == "" ]]; then
		firefox "$i" &
		sleep 5
	else
		firefox --new-tab "$i" &
	fi
done
