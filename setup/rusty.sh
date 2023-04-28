#!/bin/bash
#
# Bootstraping my rust development server
#
# Usage: curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/setup/rusty.sh | bash
#

set -e
sudo apt-get update
sudo NEEDRESTART_MODE=a apt-get -y dist-upgrade

# Fix MTU settings
sudo sed -i '/      dhcp4: true/a\      mtu: 1400' /etc/netplan/00-installer-config.yaml

# general utilities
sudo NEEDRESTART_MODE=a apt-get install -y\
  apt-transport-https\
  build-essential\
  ca-certificates\
  cgroup-tools\
  cmake\
  curl\
  git\
  protobuf-compiler\
  qemu-guest-agent\
  spice-vdagent\
  spice-webdavd\
  tmux\
  tree\
  zlib1g-dev\
  zsh\

curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo NEEDRESTART_MODE=a apt-get update
sudo NEEDRESTART_MODE=a apt-get -y install docker-ce docker-ce-cli docker docker-compose-plugin
sudo gpasswd -a $USER docker

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

sudo chsh -s $(which zsh) $(whoami)

# Install rustup
curl https://sh.rustup.rs -sSf | sh -s -- -y
