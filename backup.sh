#!/bin/bash

FILE_NAME=homeserver-$(date +"%Y-%m-%d").tar.bz2

cd /nas

# #Copy dir to backup and exclude unnecessary folders
# rsync -av /nas/* /nas/backup/compression/ --exclude /media-center/data --exclude /backup/ --exclude /media-center/docker/jellyfin-config/cache --exclude "media-center/docker/jellyfin-config/transcodes" --exclude "media-center/docker/plex-config/Library/Application Support/Plex Media Server/Cache" --exclude "media-center/docker/sonarr-config/MediaCover" --exclude "media-center/docker/readarr-config/MediaCover" --exclude "media-center/docker/radarr-config/MediaCover" --exclude "media-center/docker/plex-config/Library/Application Support/Plex Media Server/Media" --exclude "media-center/docker/jellyfin-config/data/metadata/People"

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
    --exclude='backup' \
    -cvpjf $FILE_NAME * 

# cp $FILE_NAME backup/google-drive

# rm $FILE_NAME

# export HOME=/home/homeserver

# sudo bash /home/homeserver/butdr/cron_backup.bash