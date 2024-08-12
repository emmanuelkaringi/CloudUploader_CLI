#!/bin/bash

########
# Author: Emmanuel Kariithi
# Date: 12-08-2024
#
# Version: v2
#
# A Simple CLI Tool for Uploading Files to AWS S3
#
########

# Introduction
clear
echo "##############################################"
echo "# Welcome to CloudUploader - AWS S3 CLI Tool #"
echo "##############################################"
echo ""
echo "This tool allows you to seamlessly upload files to your AWS S3 bucket."
echo "You can specify an optional target directory within the bucket, and handle"
echo "existing files with options to overwrite, skip, or rename."
echo ""
echo "Let's get started!"
echo ""

# Prompt the user for the S3 bucket name
read -p "Enter your S3 bucket name: " BUCKET_NAME

# Check if the S3 bucket exists
if ! aws s3 ls "s3://$BUCKET_NAME" > /dev/null 2>&1; then
    echo "The S3 bucket $BUCKET_NAME does not exist. Please check the name and try again."
    exit 1
else
    echo "S3 bucket $BUCKET_NAME found. Proceed."
fi

# Prompt the user for the optional target directory within the S3 bucket
read -p "Enter the target directory within the S3 bucket (press Enter to skip): " TARGET_DIR

# Check if the directory exists within the bucket, if specified
if [ -n "$TARGET_DIR" ]; then
    if ! aws s3 ls "s3://$BUCKET_NAME/$TARGET_DIR/" > /dev/null 2>&1; then
        echo "The directory $TARGET_DIR does not exist in the bucket $BUCKET_NAME. Please check the name and try again."
        exit 1
    else
        echo "Directory $TARGET_DIR found within the bucket $BUCKET_NAME."
    fi
fi

# Prompt the user for the file path
read -p "Enter the path to the file you want to upload (e.g. /home/user/Downloads/file.txt): " FILE


# Check if the file exists
if [ -f "$FILE" ]; then
	echo "File $FILE found."
else
	echo "File $FILE does not exist. Please check the file path and try again."
	exit 1
fi

# Extract the file name and extension
BASENAME=$(basename "$FILE")
FILENAME="${BASENAME%.*}"
EXTENSION="${BASENAME##*.}"


# Construct the S3 path
if [ -n "$TARGET_DIR" ]; then
    S3_PATH="s3://$BUCKET_NAME/$TARGET_DIR/$BASENAME"
else
    S3_PATH="s3://$BUCKET_NAME/$BASENAME"
fi

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
			read -p "Enter a new name for the file (without extension): " new_name
			if [ -n "$TARGET_DIR" ]; then
                NEW_S3_PATH="s3://$BUCKET_NAME/$TARGET_DIR/$new_name.$EXTENSION"
            else
                NEW_S3_PATH="s3://$BUCKET_NAME/$new_name.$EXTENSION"
            fi
            echo "Uploading as a new file with the name $new_name.$EXTENSION..."
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
	# Upload the file to S3 with a progress bar
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