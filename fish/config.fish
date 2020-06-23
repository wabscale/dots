xhost + &> /dev/null

# file stuff
alias cp='cp -v'
alias mv='mv -v'
alias rmr='rm -r'
alias rmrf='rm -rf'
alias cpr='cp -r'
alias scp='scp -v'
alias t='tree -aCFh -I .git'

# ls stuff
alias ll='ls --color=auto -l'
if which exa &> /dev/null
    alias la='exa -abghlT --ignore-glob=".bzr|CVS|.git|.hg|.svn|node_modules|__pycache__" --git'
    alias l='exa -abghl --git'
else
    alias la='ls --color=auto -a'
    alias l='ls --color=auto -aCFlh'
end

# grep related
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,node_modules} -n'

# git
alias gits='git status -s'
alias gita='git add'
alias gitd='git diff'
alias gitg='git grep'
alias gitb='git branch'
alias gitch='git checkout'
alias gitcout='git checkout --'
alias gitm='git merge'
alias gitl='git log'
alias gitre='git reset'
alias gitsh='git push'
alias gitll='git pull'
alias gitssh='git push --set-upstream origin (git branch --show-current)'
alias gitsave='git config credential.helper store'
alias gitbare='git config --bool core.bare true'
alias gitrm='git rm'
alias gitcl='git clone --recurse-submodules'

# for network tests
alias wget='wget -v'

# python
alias ipy='ipython3 --autocall 1 -i'
alias ipy3='ipython3 --autocall 1 -i'
alias ipy2='ipython2 --autocall 1 -i'

# for ccrypt
alias cpt='ccrypt -v'

# BashBunny
# alias sshbunny='sudo screen /dev/tty.usbmodemch000001 115200'
# export BUNNYPATH=/Volumes/BashBunny/

# xclip
alias xclip='xclip -selection c'


# docker
alias dr='docker'
alias dps='docker ps'
alias drmi='docker rmi'
alias dls='docker image ls'
alias dshell='docker run -it -v (pwd):~/host --workdir ~/host --rm debian:stretch'
alias ashell='docker run -it -v (pwd):~/host --workdir ~/host --rm alpine:3.9'

# docker-compose
alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcu='docker-compose up'
alias dcr='docker-compose run'
alias dcd='docker-compose down'
alias dck='docker-compose kill'

# misc.
alias cl='clear; cat ~/dots/zsh/(hostname) | lolcat'
alias rsync='rsync -r -v --progress -e ssh'
alias src='unalias -a; source ~/.zshrc'
alias erc='e ~/.zshrc; source ~/.zshrc'
alias efunc='e ~/dots/zsh/.functions'
alias ealias='e ~/dots/zsh/.aliases'
alias base64='base64 -w 0'
alias curl='curl --silent'
alias cll='clear; l'
alias ctl=systemctl
alias de=deactivate
alias startx=xinit # don't ask
alias top=htop
alias wh=which
alias p=ccat
alias q=exit

# lolz
alias gimmemake='cp ~/dots/templates/Makefile ./ && touch requirements.txt'
alias gimmesolve='cp ~/dots/templates/solve ./'
alias gimmedenv='cp -r ~/dots/templates/denv ./'
alias onoz='less /var/log/errors.log'
alias plz='sudo (fc -ln -1)'
alias wtf='dmesg | less'
alias gimme='touch'

alias ghci='docker run --rm -it -w /opt/pl -v (pwd):/opt/pl -u (id -u):(id -g) haskell ghci'
alias haskell='docker run --rm -it -w /opt/pl -v (pwd):/opt/pl -u (id -u):(id -g) haskell bash'


function gitc # git commit
    git commit -m "$argv"
end

function gitdb # git delete branch
    for i in $argv
        git push origin --delete $argv
        git branch -D $argv
        echo "deleted $argv"
    end
end

function gitcb # git create branch
    if count $argv | xargs test 2 -eq
        return 1
    end
    git checkout -b $argv[1] $argv[2]
    git push --set-upstream origin $argv[1]
    echo "created $argv[1] from $argv[2]"
end

function gitqs # git quick save
    git pull --rebase

    if count $argv &> /dev/null
        set COMMIT_MESSAGE="CHG"
    else
        set COMMIT_MESSAGE="$argv"
    end

    # echo $COMMIT_MESSAGE
    git status
    python3 -c "print(''.join(['=' for _ in range(40)]), '', sep='\n')"
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push
end

function monport
    sudo tcpdump -vv port $argv[1] and '(tcp-syn|tcp-ack)!=0'
end

function lsport
    lsof -i tcp:$argv[1]
end

function cd
    builtin cd $argv
    pwd > ~/.lastdir
end

function c
    if count $argv &> /dev/null
        cd ..;
        l;
    else
        cd $argv;
        l;
    end
    pwd > ~/.lastdir
end

function pack
    if tar zcvf $argv[1].tgz $argv
        echo packed into $argv[1].tgz
    end
end

function e
    if ! emacsclient -e '(daemonp)' &> /dev/null
        echo "starting daemon...";
        emacs -nw --daemon &> /dev/null;
    end
    emacsclient -nw -c "$argv"
end

function du
    if count $argv | xargs test 0 -eq
        nice du -h -d 0 (pwd)
    else
        for i in $argv
            nice du -h -d 0 $i
        end
    end
end

function dul
    if count $argv | xargs test 0 -eq
        set DU_PATH=(pwd)
    else
        set DU_PATH=(pwd)/$argv
    end

    for i in (ls -A $DU_PATH)
        nice du -h -d 0 $DU_PATH/$i;
    end | sort -h -r -
end


function gdb
    nice gdb $argv
    [ -n "(ls -a | grep peda-session)" ] && rm peda-session*
    [ -e .gdb_history ] && rm .gdb_history
end

function dkill
    docker kill (docker ps -q)
    docker system prune -f
end

function dcleanv
    docker volume ls -qf dangling=true | xargs -r docker volume rm
    docker system prune -f
end

function dclean
    # https://lebkowski.name/docker-volumes/
    dkill
    dcleanv
    docker rmi (docker image list -q)
end

function trizen
    set mode=$argv[1]
    set packages=$argv
    if test (id -u) -eq 0
        su jc -c "nice trizen $mode $packages"
    else
        nice trizen "$mode" "$packages"
    end
end

function srcv
    declare -a env_names=(
        "venv"
        "env"
    )
    for env_name in $env_names
        if test -d $env_name
            source ./$env_name/bin/activate
            break
        end
    end
end

function start
    for i in $argv
        switch "$i"
            case "d"
                echo "starting docker..."
                systemctl start docker
                ;;
            case "e"
                echo "starting spacemacs..."
                emacs --daemon -nw --insecure &> /dev/null
                ;;
            case "n"
                set interface=(ip addr | nice grep -Po 'wl([A-Za-z]|[0-9])*')
                echo "starting netctl-auto@$interface.service..."
                systemctl start netctl-auto@$interface.service
                ;;
            case "db"
                /opt/dockerfiles/mariadb/start
                ;;
            case *
                declare -A services=(
                    ["e"]="emacs"
                    ["d"]="docker"
                    ["n"]="netctl"
                )
                echo "Plz specify argument $services"
                ;;
        end
    end
end


function stop
    for i in $argv
        switch "$i"
            case "d"
                echo "stopping docker..."
                systemctl stop docker
                ;;
            case "e"
                echo "stopping spacemacs..."
                killall emacs
                ;;
            case "n"
                set interface=(ip addr | awk '{ print $2 }' | nice grep -Po 'wl([A-Za-z]|[0-9])*')
                echo "stopping netctl-auto@$interface.service..."
                systemctl stop netctl-auto@$interface.service
                ;;
            case "db"
                /opt/dockerfiles/mariadb/stop
                ;;
            case *
                declare -A services=(
                    ["e"]="emacs"
                    ["d"]="docker"
                    ["n"]="netctl"
                )
                echo "Plz specify argument $services"
                ;;
        end
    end
end


function restart
    for i in $argv
        set service="$i"
        declare -A services=(
            ["e"]="emacs"
            ["d"]="docker"
            ["n"]="netctl"
            ["db"]="mariadb"
        )

        if test -z "$services[$service]"
            echo "select service plz $services"
            return 1
        end

        echo "restarting $services[$service]..."

        begin
            stop "$service"
            start "$service"
        end &> /dev/null
    end
end


function build
    set MAN="build [service(s) | ./directory/path | .]

This tool will attempt to build the service(s) specified, or the images specified
in the current directory. If no arguments are specified then the tool will attempt
to build a docker-compose file, or dockerfile in the current directory. If a path is
specified, then the script will attempt to build the compose file, or dockerfile in
that directory.

depends on jq and ruby

eg:
build
build ./directory
build webstorm goland"

        if [ "-h" = "$argv[1]" ] || [ "--help" = "$argv[1]" ]
            echo "$MAN"
            return 0
        end

        function attempt_to_build
            # Attempts to build the compose file,
            # or the dockerfile in the specied directory
            if [ -f ./$argv[1]/docker-compose.yml ] || [ -f ./$argv[1]/docker-compose.yaml ]
                set dc_file="(ls docker-compose.y*ml | head -n 1)"
                echo "running docker-compose -f $argv[1]/$dc_file build --parallel" 1>&2
                docker-compose -f $argv[1]/$dc_file build --parallel
                return 0
            else
                if [ -f $argv[1]/Dockerfile ]
                    set tag="(basename (pwd))"
                    echo "running docker build -f $argv[1]/Dockerfile -t $tag ." 1>&2
                    docker build -f $argv[1]"/Dockerfile" -t $tag .
                    return 0
                else
                    return 1
                end
            end
        end

        function yaml2json
            ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(ARGF))' $argv
        end

        if count $argv | xargs test 0 -eq
            attempt_to_build .
            set ret_code="$status"
            if test $ret_code -ne 0
                echo "unable to build ." 1>&2
            end
            return $ret_code
        end

        if test -z "$DOCKERFILES_PATH"
            echo "DOCKERFILES_PATH not set"
            return 1
        end

        declare -A service_map

        for dc_file in (find "$DOCKERFILES_PATH" -name 'docker-compose.yml')
            for service in (yaml2json "$dc_file" | jq '.services | keys[]' -r)
                service_map[$service]="$dc_file"
            end
        end

        for arg in $argv
            if test -d "$arg"
                attempt_to_build "$arg"
            else
                if test -n "$service_map[$arg]"
                    echo "running docker-compose -f $service_map[$arg] build $arg" 1>&2
                    docker-compose -f "$service_map[$arg]" build "$arg"
                end
            end
        end
end


function md
    if count $argv | xargs test 0 -eq
        pandoc README.md | lynx -stdin
        return
    end
    pandoc $argv[1] | lynx -stdin
end


function giti
    echo >> .gitignore
    for i in $argv
        echo $i >> .gitignore
    end
end

function dockeri
    echo >> .dockerignore
    for i in $argv
        echo $i >> .dockerignore
    end
end

function ddg
    firefox "https://duckduckgo.com/?q=(echo $argv | xargs)"
end
