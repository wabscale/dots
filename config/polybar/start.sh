#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

POLYBAR_HOME=~/.config/polybar

for i in `xrandr | nice grep ' connected' | awk '{print $1}'`; do
    echo $i
    DISP="${i}" polybar -c ${POLYBAR_HOME}/prmsrswt.conf white &
done


echo "bars launched..."
