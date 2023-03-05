#!/bin/bash

killall -q polybar

if [ "$(hostname)" = "aion" ]; then
    THEME=vista1nik
else
    THEME=prmsrswt
fi

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

cd ~/.config/polybar

export WIRED=$(ip -br link show | awk '/UP/ {print $1}' | nice grep 'eno.*$' -oP | head -n 1)
export WIRELESS=$(ip -br link show | awk '/UP/ {print $1}' | nice grep 'w.*$' -oP | head -n 1)
export HWMONPATH=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | awk '/k10temp: Tctl/ {print $3}')

set_wired() {
    export INTERFACE="${WIRED}"
    sed 's/;wired //g' ${THEME}.conf.tmpl > theme.conf
}

set_wireless() {
    export INTERFACE="${WIRELESS}"
    sed 's/;wireless //g' ${THEME}.conf.tmpl > theme.conf
}

if [ -f theme.conf ]; then
    rm theme.conf
fi

if [ -n "${WIRED}" ]; then
    if ip link show | grep "${WIRED}" | grep 'NO-CARRIER'; then
        set_wireless
    else
        set_wired
    fi
else
    set_wireless
fi

for i in `xrandr | nice grep ' connected' | awk '{print $1}'`; do
    echo $i
    DISP="${i}" polybar -c theme.conf white &
done

echo "bars launched..."
