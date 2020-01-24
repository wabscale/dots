
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
} &> /dev/null
#primusrn i3

exec i3
