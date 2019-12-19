#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

POLYBAR_HOME=~/.config/polybar

export WIRED=$(ip -br link show | awk '{print $1}' | nice grep 'enp.*$' -oP)
export WIRELESS=$(ip -br link show | awk '{print $1}' | nice grep 'w.*$' -oP)

set_wired() {
    export INTERFACE="${WIRED}"
    sed 's/;wired //g' prmsrswt.conf.tmpl > prmsrswt.conf
}

set_wireless() {
    export INTERFACE="${WIRELESS}"
    sed 's/;wireless //g' prmsrswt.conf.tmpl > prmsrswt.conf
}

if [ -f prmsrswt.conf ]; then
    rm prmsrswt.conf
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
    DISP="${i}" polybar -c ${POLYBAR_HOME}/prmsrswt.conf white &
done

echo "bars launched..."
