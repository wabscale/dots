# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#     startx
# fi

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="jmc"
BULLETTRAIN_STATUS_EXIT_SHOW=true
DISABLE_AUTO_UPDATE="true"

plugins=(
    colored-man-pages
    colorize
    extract
    cp
    archlinux
    battery
    web-search
    python
)

source $ZSH/oh-my-zsh.sh
source ~/dots/zsh/.rc
