# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#     startx
# fi

case $- in
    *i*);;
    *) return;;
esac

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
    docker
    docker-compose
#    web-search
#    python
)

if [ "`hostname`" = "kalima" ]; then
    cat ~/dots/zsh/kalima | lolcat
else
    ~/dots/bin/art36 $(cat /etc/hostname)
fi

#local check_script sources

check_script="print \"$HOME/dots/bin\" in \"$PATH\""
if [ "False" = "$(python2 -c $check_script)" ]; then
    export PATH=$HOME/dots/bin:$PATH
    export PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH
fi


rm_crap() {
    local crap localls
    localls=$(ls -a ~)
    declare -a crap=(
        ".zcompdump"
        ".archey3.cfg"
        # ".zsh_history"
        # ".zcompdump"
        ".mysql_history"
        ".bash_history"
        ".lesshst"
        ".wget-hsts"
        ".pwntools-cache"
        "routersploit.log"
        ".msf4"
        ".install4j"
        ".rsf_history"
        ".cache/mozilla"
        ".java"
        ".sqlmap"
        ".sqlite_history"
        ".recently-used"
        ".python_history"
        ".oracle_jre_usage"
    )
    for i in $crap; do
        if [ -n "$(echo ${localls} | grep $i)" ]; then
            rm -rf ~/$i* &> /dev/null
        fi
    done
}

rm_crap

source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


declare -a sourcefiles=(
    ".env_vars"
    ".aliases"
    ".functions"
)
for i in $sourcefiles; do
    if [ -e $HOME/dots/zsh/$i ]; then
        source $HOME/dots/zsh/$i
    fi
done

if [ -f ~/.lastdir ]; then
   cd $(cat ~/.lastdir)
fi
