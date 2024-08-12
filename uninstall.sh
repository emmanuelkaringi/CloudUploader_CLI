#!/bin/bash

########
# Author: Emmanuel Kariithi
# Date: 12-08-2024
#
# Version: v1
#
# Uninstallation script for CloudUploader
#
########

# Define destination path
DESTINATION="/usr/local/bin/clouduploader"

# Remove the script
if [ -f "$DESTINATION" ]; then
    sudo rm "$DESTINATION"
    echo "CloudUploader has been uninstalled."
else
    echo "CloudUploader is not installed."
fi