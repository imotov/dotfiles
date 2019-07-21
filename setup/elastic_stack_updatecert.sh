#!/bin/bash

set -e

sudo systemctl stop kibana.service

# Copy new config file and SSL sertifiactes from hassio
gio mount smb://hassio@hassio.local/ssl/ || true
gio cat smb://hassio@hassio.local/ssl/fullchain.pem | sudo dd of=/etc/kibana/fullchain.pem
gio cat smb://hassio@hassio.local/ssl/privkey.pem | sudo dd of=/etc/kibana/privkey.pem
sudo chown kibana:kibana /etc/kibana/*.pem
sudo cp ~/.dotfiles/setup/kibana.yml /etc/kibana/
gio mount -u smb://hassio@hassio.local/ssl/

sudo systemctl start kibana.service
