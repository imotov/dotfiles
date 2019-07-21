#!/bin/bash
# Don't continue if anything goes wrong
set -e

scriptDir=$(dirname "$(readlink -f "$0")")
hostName=`hostname`

# Make sure we are up to date
sudo apt-get update
sudo apt-get -y dist-upgrade

# Get elastic's key
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Install dependency that is needed to get elasticsearch packages
sudo apt-get -y install apt-transport-https curl

# Registering elastic's repository
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

# Installing elasticsearch
sudo apt-get update && sudo apt-get -y install elasticsearch kibana
if [[ $hostName = "leafminer" ]] ; then
  export RAM_SIZE=6g
else
  export RAM_SIZE="$(grep MemTotal /proc/meminfo | awk '{print int($2 / 1024 / 2 / 256)*256}')m"
fi

# Adjust heap size
sudo --preserve-env=RAM_SIZE sed -i 's/\-Xm\(.\)1g/-Xm\1'${RAM_SIZE}'/g' /etc/elasticsearch/jvm.options

# Copy new config file
sudo cp $scriptDir/config/elasticsearch.yml /etc/elasticsearch/

# Strarting elasticsearch
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

# Waiting for elasticsearch to start
echo "Waiting for elastic to start"
curl -s --retry 10 --retry-connrefuse http://localhost:9200

echo "Generating passwords:"
sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto --batch > /tmp/elastic.txt

export ELASTIC_PASSWORD=$(grep "PASSWORD elastic" /tmp/elastic.txt | awk '{print $4}')
export KIBANA_PASSWORD=$(grep "PASSWORD kibana" /tmp/elastic.txt | awk '{print $4}')

sudo -u kibana /usr/share/kibana/bin/kibana-keystore create
echo kibana | sudo -u kibana /usr/share/kibana/bin/kibana-keystore add elasticsearch.username --stdin
echo $KIBANA_PASSWORD | sudo -u kibana /usr/share/kibana/bin/kibana-keystore add elasticsearch.password --stdin

if [[ $hostName = "leafminer" ]] ; then
  # SSL setup
  # Copy new config file and SSL sertificates from hassio
  gio mount smb://hassio@hassio.local/ssl/ || true
  gio cat smb://hassio@hassio.local/ssl/fullchain.pem | sudo dd of=/etc/kibana/fullchain.pem
  gio cat smb://hassio@hassio.local/ssl/privkey.pem | sudo dd of=/etc/kibana/privkey.pem
  sudo chown kibana:kibana /etc/kibana/*.pem
  sudo cp $scriptDir/config/kibana-ssl.yml /etc/kibana/kibana.yml
  gio mount -u smb://hassio@hassio.local/ssl/
else
  sudo cp $scriptDir/config/kibana.yml /etc/kibana/kibana.yml
fi

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

echo "Installation is complete"
echo "generated passwords:"
cat /tmp/elastic.txt
rm /tmp/elastic.txt
