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
  tmux\
  pbzip2\
  maven\
  jq\
  rtl-sdr\
  gqrx-sdr

curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io kubectl
sudo gpasswd -a $USER docker
sudo curl -L "https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

# Install pyenv
sudo apt-get -y install make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

sudo chsh -s $(which zsh) $(whoami)

sudo mkdir -p /media/igor/music
sudo mkdir -p /media/igor/video
sudo chown igor:staff /media/igor/music
sudo chown igor:staff /media/igor/video
