#!/bin/sh

"
Quick setup script for https://gitlab.com/b1g_J/dots
This will install the my zsh environment on debian or centOS machines.
"

# To install:
# curl https://f.bigj.dev/f/qs.sh | sh

set -e

if which apt-get; then
    sudo apt-get update
    sudo apt-get install -y git zsh python3 python3-pip
elif which yum; then
    sudo yum update
    sudo yum install git zsh python3
fi

if [ -d ~/.oh-my-zsh ]; then rm -rf ~/.oh-my-zsh; fi
if [ -d ~/dots ]; then rm -rf ~/dots; fi
if [ -f ~/.zshrc ]; then rm ~/.zshrc; fi

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://gitlab.com/b1g_J/dots.git ~/dots

ln -s ~/dots/zsh/.zshrc ~/.zshrc


echo "export TERM=xterm-256color" >> ~/dots/zsh/.env_vars
echo "export ZSH_THEME=gnzh" >> ~/dots/zsh/.env_vars
echo "export SKIP_BANNER=true" >> ~/dots/zsh/.env_vars

chsh -s $(which zsh)
