#!/bin/zsh

# Assuming that we already setup repo in elasticearch setup
sudo apt-get install kibana

if [[ ! -a /var/lib/kibana/kibana.keystore ]]; then
  if [[ -z "$KIBANA_PASSWORD" ]]; then
      echo "Run KIBANA_PASSWORD=password ./kibana.zsh"
      exit 1
  fi
  sudo -u kibana /usr/share/kibana/bin/kibana-keystore create
  echo kibana | sudo -u kibana /usr/share/kibana/bin/kibana-keystore add elasticsearch.username --stdin
  echo $KIBANA_PASSWORD | sudo -u kibana /usr/share/kibana/bin/kibana-keystore add elasticsearch.password --stdin
fi

# Copy new config file and SSL sertifiactes from hassio
gio mount smb://hassio@hassio.local/ssl/ || true
gio cat smb://hassio@hassio.local/ssl/fullchain.pem | sudo dd of=/etc/kibana/fullchain.pem
gio cat smb://hassio@hassio.local/ssl/privkey.pem | sudo dd of=/etc/kibana/privkey.pem
sudo chown kibana:kibana /etc/kibana/*.pem
sudo cp ~/.dotfiles/setup/kibana.yml /etc/kibana/
gio mount -u smb://hassio@hassio.local/ssl/

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

echo "Kibana is installed"
