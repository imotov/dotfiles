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
  curl\
  zsh\
  apt-transport-https\
  ca-certificates\
  gnome-tweaks\
  flameshot\
  rclone\
  tree\
  tmux

curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo gpasswd -a $USER docker

# setup dotfiles and enviroments
git clone -q git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh/plugins && git clone -q git://github.com/zsh-users/zsh-syntax-highlighting.git
git clone -q https://github.com/imotov/dotfiles.git ~/.dotfiles
. ~/.dotfiles/push

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

chsh -s /usr/bin/zsh
