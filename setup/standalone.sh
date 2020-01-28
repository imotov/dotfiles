#!/bin/bash
#
# Additional software for standalone setup
#

set -e
sudo apt-get update
sudo apt-get install -y\
  lm-sensors\
  powertop\
  gadmin-openvpn-client\
  network-manager-openvpn\
  network-manager-openvpn-gnome\
  openvpn\
  powertop\
  tlp\


sudo snap install spotify
# sudo snap install slack --classic

#docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

curl -o ~/Downloads/zoom_amd64.deb -L https://zoom.us/client/latest/zoom_amd64.deb)
sudo dpkg -i ~/Downloads/zoom_amd64.deb
sudo apt-get install -f
