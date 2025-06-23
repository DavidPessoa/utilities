#!/bin/bash

source /nas/utilities/.env

# URL to fetch
url="https://developer.lge.com/secure/ResetDevModeSession.dev?sessionToken=$WEBOS_TOKEN"

# Log file location     
log_file="/var/log/webos-dev-renewal.log"

# Execute the curl command and append output and errors to log file
curl "$url" >> "$log_file" 2>&1