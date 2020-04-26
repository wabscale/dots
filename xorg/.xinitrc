
cd ~
{
    xrdb ~/.Xresources
    ~/.fehbg &
    picom &> /dev/null &
    if ip addr | grep enp0s20f0u6u4; then
        dhcpcd -N enp0s20f0u6u4 &
    fi
    # emacs --insecure --daemon &
    #if [ "`hostname`" = "Ra" ]; then
    #    xrandr --setprovideroutputsource modesetting NVIDIA-0
    #    xrandr --auto
    #fi
    xset -dpms
    xset s off
} &> /dev/null
#primusrn i3

#sh ~/.screenlayout/main.sh

if xrandr | grep 'DP-4'; then
    xrandr --output DP-4 --mode 2560x1440 -r 144
fi

exec i3
