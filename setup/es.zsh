#!/bin/zsh
# Don't continue if anything goes wrong
set -e
# Get elastic's key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Install dependency that is needed to get elasticsearch packages
sudo apt-get install apt-transport-https

# Registering elastic's repository
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

# Installing elasticsearch
sudo apt-get update && sudo apt-get install elasticsearch

# Increase heap size to 6G
sudo sed -i 's/\-Xm\(.\)1g/-Xm\16g/g' /etc/elasticsearch/jvm.options

# Copy new config file
sudo cp ~/.dotfiles/setup/elasticsearch.yml /etc/elasticsearch/

# Strarting elasticsearch
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

echo "Run sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto"
