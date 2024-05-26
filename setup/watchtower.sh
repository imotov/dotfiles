
#!/bin/bash
#
# Bootstraping the watchtower server
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
  rtl-sdr\
  tree\
  zsh\
  

curl -sk https://raw.githubusercontent.com/imotov/dotfiles/master/bootstrap | zsh

# Add docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add vscode repository
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

# Install docker and vscode
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin code
sudo gpasswd -a $USER docker

pushd ~/.dotfiles
# Set proper url for .dotfiles remote repository
git remote set-url origin git@github.com:imotov/dotfiles.git
popd

sudo chsh -s $(which zsh) $(whoami)

echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda",   ATTRS{idProduct}=="2832", MODE:="0666"'  | sudo tee /etc/udev/rules.d/20-rtl-sdr.rules > /dev/null
