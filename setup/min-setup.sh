#!/bin/bash
#
# Bootstraping minimal development environment on Ubuntu
#

set -e
sudo apt-get update
sudo apt-get -y dist-upgrade

if [[ -n "$MACHINE_NAME" ]]; then
  sudo --preserve-env=MACHINE_NAME sed -i "s/ubuntu/$MACHINE_NAME/g" /etc/hosts
  sudo --preserve-env=MACHINE_NAME sed -i "s/ubuntu/$MACHINE_NAME/g" /etc/hostname
fi

sudo apt-get install -y\
  apt-transport-https\
  ca-certificates\
  gnome-tweaks\

sudo snap install atom --classic

# chrome
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb https://dl.google.com/linux/chrome/deb/ stable main"
sudo apt-get update
sudo apt-get install -y google-chrome-stable

echo "Restart the system"
