#!/bin/bash

# Provision a server quickly with the basics (docker, docker-compose, python3 ... )

set -ex

> sshd_config cat <<EOF
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
AllowAgentForwarding yes
X11Forwarding no
PrintMotd no
AcceptEnv LANG LC_*
EOF

sudo chown root:root sshd_config
sudo mv sshd_config /etc/ssh/sshd_config

if (( $(id -u) == 0 )); then
    mkdir -p ~/.ssh
    chmod 766 ~/.ssh
    sudo cp /root/.ssh/authorized_keys ~/.ssh/authorized_keys
    sudo chown ${USER}:${USER} ~/.ssh/authorized_keys
fi

sudo apt update
yes | sudo apt upgrade -y
sudo apt install -y git curl python3 python3-pip

curl https://get.docker.com | sh
sudo pip3 install docker-compose

sudo usermod -aG docker ${USER}

echo 'You will need to either reboot or logout for the docker permissions to work'
