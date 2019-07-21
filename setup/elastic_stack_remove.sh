#!/bin/bash
# Don't continue if anything goes wrong
set -e

sudo apt-get remove elasticsearch kibana
sudo rm -rf /var/lib/elasticsearch
sudo rm -rf /etc/elasticsearch
sudo rm -rf /var/lib/kibana
sudo rm -rf /etc/kibana
