#!/bin/bash

# Define destination path
DESTINATION="/usr/local/bin/clouduploader"

# Copy the script to the destination directory
sudo cp clouduploader.sh $DESTINATION

# Make the script executable
sudo chmod +x $DESTINATION

# Confirm installation
if [ -f "$DESTINATION" ]; then
    echo "CloudUploader installed successfully."
    echo "You can now run it using the command 'clouduploader'."
else
    echo "Installation failed. Please try again."
fi