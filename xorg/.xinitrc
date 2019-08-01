
cd ~
{
    xrdb ~/.Xresources
    ~/.fehbg &
    compton &> /dev/null &
    emacs --insecure --daemon &
    #if [ "`hostname`" = "Ra" ]; then
    #    xrandr --setprovideroutputsource modesetting NVIDIA-0
    #    xrandr --auto
    #fi
} &> /dev/null
#primusrun i3
exec i3
