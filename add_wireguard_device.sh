#!/bin/bash

# Check for device name argument
if [ -z "$1" ]; then
  echo "Usage: $0 <device_name>"
  exit 1
fi

# Variables
DEVICE_NAME=$1
WG_DIR="/nas/utilities/docker/wireguard-config"
DEVICE_DIR="$WG_DIR/devices"
NEW_DEVICE_DIR="$DEVICE_DIR/$DEVICE_NAME"
SERVER_PUBLIC_KEY=$(cat "$WG_DIR/server/publickey-server")
SERVER_IP="31.151.136.58"

# Count existing device folders
DEVICE_COUNT=$(ls -l $DEVICE_DIR | grep ^d | wc -l)

# Calculate new IP
IP_LAST_OCTET=$((DEVICE_COUNT + 2))
NEW_IP="10.13.13.$IP_LAST_OCTET"

# Create device folder
mkdir -p "$NEW_DEVICE_DIR"

# Generate keys and pre-shared key
wg genkey | tee "$NEW_DEVICE_DIR/privatekey" | wg pubkey > "$NEW_DEVICE_DIR/publickey"
wg genpsk > "$NEW_DEVICE_DIR/presharedkey"

# Extract keys and pre-shared key
PRIVATE_KEY=$(cat "$NEW_DEVICE_DIR/privatekey")
PUBLIC_KEY=$(cat "$NEW_DEVICE_DIR/publickey")
PRESHARED_KEY=$(cat "$NEW_DEVICE_DIR/presharedkey")

# Add new Peer to Server config
echo -e "\n[Peer]\nPublicKey = $PUBLIC_KEY\nPresharedKey = $PRESHARED_KEY\nAllowedIPs = $NEW_IP/32" >> "$WG_DIR/wg0.conf"

# Restart WireGuard container
docker restart wireguard

# Create client config
CLIENT_CONFIG="$NEW_DEVICE_DIR/$DEVICE_NAME.conf"
echo "[Interface]
PrivateKey = $PRIVATE_KEY
Address = $NEW_IP/32
DNS = 10.13.13.1
ListenPort = 51820

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
PresharedKey = $PRESHARED_KEY
Endpoint = $SERVER_IP:51820
AllowedIPs = 10.13.13.0/24,192.168.178.0/24" > $CLIENT_CONFIG

# Generate QR code for the client config
qrencode -t ansiutf8 < $CLIENT_CONFIG

echo "Device $DEVICE_NAME added with IP $NEW_IP."
