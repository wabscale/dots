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
export GPG_TTY=$(tty)

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
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
#    conda-zsh-completion
#    web-search
#    python
)


append_path () {
    case ":$PATH:" in
        *:"$1":*)
        ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

export GPG_TTY=$(tty)


#BANNER_FILE=$(echo $HOME/dots/zsh/`cat /etc/hostname` | awk '{print tolower($0)}')
#if [ -f ${BANNER_FILE} ]; then
#    cat ${BANNER_FILE} | lolcat
#fi

#local check_script sources

include_paths=(
    "$HOME/dots/bin"
    "$HOME/.gem/ruby/2.7.0/bin"
    "$HOME/.yarn/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    "$HOME/.local/bin"
    "/opt/conda/bin"
)

for p in ${include_paths[@]}; do
    append_path $p
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
        ".psql_history"
        ".rediscli_history"
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

rm_crap &>/dev/null


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

### Zsh fzf-tabs configuration
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

for i in $sourcefiles; do
    if [ -e $HOME/dots/zsh/$i ]; then
        source $HOME/dots/zsh/$i
    fi
done

function aconda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        # . "/opt/conda/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
        # export PATH="/opt/conda/bin:$PATH"  # commented out by conda initialize
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda activate py310_64
}

