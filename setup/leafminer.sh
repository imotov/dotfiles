#!/bin/bash
#
# Bootstraping my server
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

# general utilities
sudo apt-get install -y\
  git\
  cgroup-tools\
  curl\
  zsh\
  apt-transport-https\
  ca-certificates\
  cifs-utils\
  gnome-tweaks\
  flameshot\
  rclone\
  tree\
  tmux

curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo gpasswd -a $USER docker
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

chsh -s /usr/bin/zsh
