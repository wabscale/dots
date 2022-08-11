#!/bin/sh

"
Quick setup script for https://gitlab.com/b1g_J/dots
This will install the my zsh environment on debian or centOS machines.
"

# To install:
# curl https://f.bigj.dev/f/qs.sh | sh

set -ex

if which apt-get; then  # debian
    sudo apt-get update
    sudo apt-get install -y git zsh python3 python3-pip emacs-nox fzf
elif which yum; then  # redhat
    sudo yum update
    sudo yum install git zsh python3 fzf
elif which pacman; then  # arch
    sudo pacman -Syu git zsh python python-pip emacs-nox fzf
fi

if [ -d ~/.oh-my-zsh ]; then rm -rf ~/.oh-my-zsh; fi
if [ -d ~/dots ]; then rm -rf ~/dots; fi
if [ -f ~/.zshrc ]; then rm ~/.zshrc; fi

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/wabscale/dots.git ~/dots

ln -s ~/dots/zsh/.zshrc ~/.zshrc

echo "export TERM=xterm-256color" >> ~/dots/zsh/.env_vars
echo "export ZSH_THEME=gnzh" >> ~/dots/zsh/.env_vars
echo "export SKIP_BANNER=true" >> ~/dots/zsh/.env_vars

mkdir -p ~/.emacs.d
>~/.emacs.d/init.el cat<<EOF
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (web-mode multi-web-mode drag-stuff yaml-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


(if (not (package-installed-p 'yaml-mode))
    (progn
      (package-refresh-contents)
      (package-install 'yaml-mode)))

(if (not (package-installed-p 'drag-stuff))
    (progn
      (package-refresh-contents)
      (package-install 'drag-stuff)))

(if (not (package-installed-p 'web-mode))
    (progn
      (package-refresh-contents)
      (package-install 'web-mode)))


(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\.yml\'" . yaml-mode))

(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode t)
(drag-stuff-define-keys)

(setq make-backup-files nil)
EOF

chsh -s $(which zsh)
