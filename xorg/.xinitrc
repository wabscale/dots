
cd ~
{
    #~/.screenlayout/dual.sh
    xrdb ~/.Xresources
    ~/.fehbg &
    # picom -e 1 -i 1 -m 1 -I 1 --vsync -b
    xcompmgr &
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

#if xrandr | grep 'DP-0'; then
#    xrandr --output DP-0 --mode 2560x1440 -r 144
#fi

# killall -9 kwalletd5
# kwalletd5 &

# killall -9 guake
# guake &

# ibus-daemon -drxR

# if which dunst; then
#     killall -9 dunst
#     dunst &
# fi


export XDG_CURRENT_DESKTOP=XFCE
killall -9 dunst guake kwalletd5 ibus-daemon

sudo systemctl stop ping sshd

exec i3
