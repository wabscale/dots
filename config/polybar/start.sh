#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

# polybar -c /root/.config/polybar/top example &
# polybar -c /root/.config/polybar/bottom bottom &

polybar -c /root/.config/polybar/prmsrswt white &

if [ -n "$(xrandr | grep DP2\ connected)" ]; then
    polybar -c /root/.config/polybar/prmsrswt.monitor white &
    # polybar -c /root/.config/polybar/bottom.monitor bottom &
    # polybar -c /root/.config/polybar/top.monitor example &
fi


echo "bars launched..."
