#!/bin/bash

# Make users and group
sudo useradd prometheus -u 13017
sudo useradd grafana -u 13018
sudo useradd portainer -u 13019
sudo useradd fireflyiii -u 13020
sudo useradd nginx -u 13040
sudo useradd immich -u 13043

sudo groupadd utilities -g 130010
sudo usermod -a -G utilities prometheus
sudo usermod -a -G utilities grafana
sudo usermod -a -G utilities portainer
sudo usermod -a -G utilities homeserver
sudo usermod -a -G utilities fireflyiii
sudo usermod -a -G utilities nginx
sudo usermod -a -G utilities immich

# Make directories
sudo mkdir -pv docker/{prometheus,grafana,portainer,fireflyiii,nginx,immich}-config
sudo mkdir -pv data/{prometheus,grafana,portainer,fireflyiii,nginx,immich}

# Set permissions
sudo chmod -R 775 data/
sudo chown -R $(id -u):utilities data/
sudo chown -R prometheus:utilities docker/prometheus-config
sudo chown -R prometheus:utilities data/prometheus
sudo chown -R grafana:utilities docker/grafana-config
sudo chown -R grafana:utilities data/grafana
sudo chown -R portainer:utilities docker/portainer-config
sudo chown -R fireflyiii:utilities docker/fireflyiii-config
sudo chown -R nginx:utilities docker/nginx-config
sudo chown -R immich:utilities docker/immich-config
sudo chown -R immich:utilities data/immich

echo "UID=$(id -u)" >> .env
