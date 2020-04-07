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
    zsh-autosuggestions
    zsh-syntax-highlighting
#    web-search
#    python
)

if [ -f ~/dots/zsh/.env ]; then
    source ~/dots/zsh/.env_vars
fi

BANNER_FILE=$(echo $HOME/dots/zsh/`hostname` | awk '{print tolower($0)}')
if [ -f ${BANNER_FILE} ]; then
    cat ${BANNER_FILE} | lolcat
fi

#local check_script sources

include_paths=(
    "$HOME/dots/bin"
    "$HOME/.gem/ruby/2.7.0/bin"
    "$HOME/.yarn/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
)

for p in ${include_paths[@]}; do
    if ! echo $PATH | grep $p &> /dev/null; then
        export PATH=$p:$PATH
    fi
done


rm_crap() {
    local crap localls
    localls=$(ls -a ~)
    declare -a crap=(
        ".zcompdump"
        ".archey3.cfg"
        ".nv"
        ".grip"
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
        ".node_repl_history"
    )
    for i in $crap; do
        if [ -n "$(echo ${localls} | grep $i)" ]; then
            rm -rf ~/$i* &> /dev/null
        fi
    done
}

rm_crap


sourcefiles=(
    ".env_vars"
    ".aliases"
    ".functions"
    ".env_vars"
)
for i in $sourcefiles; do
    if [ -e $HOME/dots/zsh/$i ]; then
        source $HOME/dots/zsh/$i
    fi
done

if [ -f ~/.lastdir ]; then
   cd "$(cat ~/.lastdir)"
fi

source $ZSH/oh-my-zsh.sh

for i in $sourcefiles; do
    if [ -e $HOME/dots/zsh/$i ]; then
        source $HOME/dots/zsh/$i
    fi
done

if [ -d ~/.asdf ]; then
    source ~/.asdf/asdf.sh
    source ~/.asdf/completions/asdf.bash
fi

