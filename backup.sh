#!/bin/bash

FILE_NAME=homeserver-$(date +"%Y-%m-%d").tar.bz2

cd /nas

tar --exclude='media-center/data' \
    --exclude='media-center/docker/jellyfin-config/cache' \
    --exclude='media-center/docker/jellyfin-config/transcodes' \
    --exclude='media-center/docker/jellyfin-config/metadata' \
    --exclude='media-center/docker/jellyfin-config/data/transcodes' \
    --exclude='media-center/docker/jellyfin-config/data/metadata' \
    --exclude='media-center/docker/emby-config/metadata' \
    --exclude='media-center/docker/emby-config/cache' \
    --exclude='media-center/docker/sonarr-config/MediaCover' \
    --exclude='media-center/docker/radarr-config/MediaCover' \
    --exclude='media-center/docker/emby-config/transcoding-temp' \
    --exclude='media-center/docker/jellyfin-config/plugins/configurations/intros/cache' \
    --exclude='smarthome/docker/node-red-config/node_modules' \
    --exclude='smarthome/docker/node-red-config/.npm/_cacache' \
    --exclude='backup' \
    -cpjf $FILE_NAME * 

cp $FILE_NAME backup/

rm $FILE_NAME

cd backup 

ls -tp | grep -v '/$' | tail -n +8 | xargs -I {} rm -- {}

rclone sync /nas/backup/ homeserver:backup