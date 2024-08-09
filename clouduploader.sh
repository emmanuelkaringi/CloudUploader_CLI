#!/bin/bash

########
# Author: Emmanuel Kariithi
# Date: 09-08-2024
#
# Version: v1
#
# A Simple CLI Tool for Uploading Files to AWS S3
#
########

# Check if the user provided a file path as an argument
if [ -z "$1" ]; then
	echo "Usage: clouduploader /path/to/file.txt"
	exit 1
fi

# Store the file path in a variable
FILE=$1


# Check if the file exists
if [ -f "$FILE" ]; then
	echo "File $FILE found."
else
	echo "File $FILE does not exist."
	exit 1
fi

# Extract the file name and extension
BASENAME=$(basename "$FILE")
FILENAME="${BASENAME%.*}"
EXTENSION="${BASENAME##*.}"


# Specify the S3 bucket name
BUCKET_NAME="Input-your-bucket-name-here"
S3_PATH="s3://$BUCKET_NAME/$BASENAME"

# Check if the file already exists in the s3 bucket
if aws s3 ls "$S3_PATH" > /dev/null 2>&1; then
	echo "File already exists in the cloud at $S3_PATH."
	echo "Choose an option:"
	echo "1) Overwrite"
	echo "2) Skip"
	echo "3) Rename"
	read -p "Enter the number of your choice: " choice

	case $choice in
		1)
			echo "Overwriting the file..."
			pv "$FILE" | aws s3 cp - "$S3_PATH"
			;;
		2)
			echo "Skipping the upload."
			exit 0
			;;
		3)
			read -p "Enter a new name for the file: " new_name
			NEW_S3_PATH="s3://$BUCKET_NAME/$new_name.$EXTENSION"
			echo "Uploading as a new file with name $new_name.$EXTENSION..."
			pv "$FILE" | aws s3 cp - "$NEW_S3_PATH"
			echo "Deleting the old file..."
			pv "$FILE" | aws s3 rm "$S3_PATH"
			S3_PATH="$NEW_S3_PATH"
			;;
		*)
			echo "Invalid choice. Exiting."
			exit 1
			;;
	esac
else
	# Upload the file to S3 without a progress bar
	echo "Uploading the file..."
	pv "$FILE" | aws s3 cp - "$S3_PATH"
fi

# Check if the upload was succesful
if [ $? -eq 0 ]; then
	echo "File uploaded successfully to $S3_PATH"

	# Generate a pre-signed URL valid for 1 hour
	URL=$(aws s3 presign "$S3_PATH" --expires-in 3600)

	echo "Here is a shareable link valid for 1 hour: $URL"
else
	echo "Failed to upload the file. Try again."
	exit 1
fi
