#!/bin/bash
#
# Bootstraping my server
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

# general utilities
sudo apt-get install -y\
  apt-transport-https\
  build-essential\
  ca-certificates\
  cgroup-tools\
  cifs-utils\
  curl\
  flameshot\
  git\
  gnome-tweaks\
  gqrx-sdr\
  jq\
  jekyll\
  maven\
  nfs-common\
  pbzip2\
  rclone\
  rtl-sdr\
  ruby-full\
  tmux\
  tree\
  zsh\
  zlib1g-dev\


curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh

# Add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add kubernetes repository - possibly need to bump the version!!!
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Add vscode repository
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Add nvidia container toolkit repository
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install docker, kubernetes, helm, microk8s and vscode
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io kubectl docker-compose-plugin code nvidia-container-toolkit
sudo gpasswd -a $USER docker
sudo snap install microk8s --classic
sudo snap install helm --classic
sudo usermod -a -G microk8s $(whoami)

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

# Install pyenv
sudo apt-get -y install make libssl-dev\
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

sudo chsh -s $(which zsh) $(whoami)

echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda",   ATTRS{idProduct}=="2832", MODE:="0666"'  | sudo tee /etc/udev/rules.d/20-rtl-sdr.rules > /dev/null

curl https://sh.rustup.rs -sSf | sh -s -- -y
sudo apt install -y protobuf-compiler cmake

sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install minikube
pushd ~/Downloads
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
popd