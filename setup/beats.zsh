#!/bin/zsh
# Don't continue if anything goes wrong
set -e
# Assuming that we already setup repo in elasticearch setup

if [[ -z "$BEATS_PASSWORD" || -z "$KIBANA_PASSWORD" || -z "$ELASTIC_PASSWORD" ]]; then
    echo "Run BEATS_PASSWORD=password KIBANA_PASSWORD=password ELASTIC_PASSWORD=password ./beats.zsh"
    exit 1
fi

sudo apt-get install metricbeat

sudo cp  ~/.dotfiles/setup/config/metricbeat.yml /etc/metricbeat/
sudo --preserve-env=BEATS_PASSWORD sed -i "s/BEATS_PASSWORD/$BEATS_PASSWORD/g" /etc/metricbeat/metricbeat.yml
sudo --preserve-env=KIBANA_PASSWORD sed -i "s/KIBANA_PASSWORD/$KIBANA_PASSWORD/g" /etc/metricbeat/metricbeat.yml

sudo /usr/share/metricbeat/bin/metricbeat --path.config /etc/metricbeat/ -E "output.elasticsearch.username=elastic" -E "output.elasticsearch.password=$ELASTIC_PASSWORD" setup --index-management
sudo /usr/share/metricbeat/bin/metricbeat --path.config /etc/metricbeat/ \
    -path.home /usr/share/metricbeat \
    -path.config /etc/metricbeat \
    -path.data /var/lib/metricbeat setup --dashboards

# sudo /bin/systemctl daemon-reload
# sudo /bin/systemctl enable metricbeat.service
# sudo systemctl start metricbeat.service

echo "Metricbeat is installed"
