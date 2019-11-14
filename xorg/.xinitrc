
cd ~
{
    xrdb ~/.Xresources
    ~/.fehbg &
    compton &> /dev/null &
    if ip addr | grep enp0s20f0u5u4; then
        dhcpcd -N enp0s20f0u5u4 &
    fi
    # emacs --insecure --daemon &
    #if [ "`hostname`" = "Ra" ]; then
    #    xrandr --setprovideroutputsource modesetting NVIDIA-0
    #    xrandr --auto
    #fi
} &> /dev/null
#primusrun i3
exec i3
