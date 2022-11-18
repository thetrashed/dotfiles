#!/bin/bash
trash_dir=$(ls -a $HOME/.trash)

for i in "$@"; do
	if [[ "$trash_dir" =~ .*"$i".* ]]; then
		mv -v "$i" "/home/ameer/.trash/$RANDOM$i$RANDOM"
	else
		mv -v "$i" /home/ameer/.trash/ 
	fi
done
