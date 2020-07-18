#!/bin/bash
#
# Bootstraping tick
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

sudo sed -i "s/ubuntu/tick/g" /etc/hosts
sudo sed -i "s/ubuntu/tick/g" /etc/hostname

# general utilities
sudo apt-get install -y\
  git\
  curl\
  zsh\
  apt-transport-https\
  ca-certificates\
  gnome-tweaks\
  flameshot\
  powertop\
  rclone\
  tree\
  tlp\


# custom apt repositories
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get update
sudo apt-get install -y\
  google-chrome-stable\
  google-cloud-sdk\

# snap utilities
sudo snap install atom --classic
sudo snap install spotify

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
