#!/bin/bash

# Define the name of the backup file to restore
BACKUP_FILE=$1

# Define the location to restore the backup to
RESTORE_DIR=$2

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found."
    exit 1
fi

# Check if the restore directory exists
if [ ! -d "$RESTORE_DIR" ]; then
    echo "Restore directory not found."
    exit 1
fi

# Extract the backup file to the restore directory
tar -xpf "$BACKUP_FILE" -C "$RESTORE_DIR"