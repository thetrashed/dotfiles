#!/bin/bash

killall -q polybar

polybar topbar 2>&1 | tee -a /tmp/polybar.log & disown
polybar bottombar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
