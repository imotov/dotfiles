#!/bin/bash
#
# Bootstraping silverfish
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

sudo sed -i "s/ubuntu/silverfish/g" /etc/hosts
sudo sed -i "s/ubuntu/silverfish/g" /etc/hostname

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


# custom apt repositories
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"

sudo apt-get update
sudo apt-get install -y\
  google-chrome-stable\


# snap utilities
sudo snap install atom --classic

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

echo "- reboot"
