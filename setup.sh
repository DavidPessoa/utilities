#!/bin/bash

# Make users and group
sudo useradd prometheus -u 13017
sudo useradd grafana -u 13018
sudo useradd portainer -u 13019
sudo useradd fireflyiii -u 13020

sudo groupadd utilities -g 130010
sudo usermod -a -G utilities prometheus
sudo usermod -a -G utilities grafana
sudo usermod -a -G utilities portainer
sudo usermod -a -G utilities homeserver
sudo usermod -a -G utilities fireflyiii

# Make directories
sudo mkdir -pv docker/{prometheus,grafana,portainer,fireflyiii}-config
sudo mkdir -pv data/{prometheus,grafana,portainer,fireflyiii}

# Set permissions
sudo chmod -R 775 data/
sudo chown -R $(id -u):utilities data/
sudo chown -R prometheus:utilities docker/prometheus-config
sudo chown -R prometheus:utilities data/prometheus
sudo chown -R grafana:utilities docker/grafana-config
sudo chown -R grafana:utilities data/grafana
sudo chown -R portainer:utilities docker/portainer-config
sudo chown -R fireflyiii:utilities docker/fireflyiii-config

echo "UID=$(id -u)" >> .env
