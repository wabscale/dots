#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

POLYBAR_HOME=~/.config/polybar

for i in `xrandr | nice grep ' connected' | awk '{print $1}'`; do
    echo $i
    if [ -f "${POLYBAR_HOME}/prmsrswt.${i}" ]; then
        echo "1"
        polybar -c ${POLYBAR_HOME}/prmsrswt.$i white &
    fi
done


echo "bars launched..."
