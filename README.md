# CloudUploader
**A Simple CLI Tool for Uploading Files to AWS S3.**

## Overview

**CloudUploader** is a bash-based command-line tool that allows users to upload files to AWS S3 quickly. It provides a seamless upload experience with options to overwrite, skip, or rename files, and it can even generate a shareable link after uploading.

## Prerequisites

Before using CloudUploader, ensure you have the following installed:

- **AWS CLI** - Make sure the AWS CLI is installed and configured with your credentials.
- **Bash Shell** - The script is written for a bash environment.
- **pv (Pipe Viewer)** - Used for showing upload progress.

## Installation
1. Clone the repository:
    ```bash
    git clone git@github.com:emmanuelkaringi/CloudUploader_CLI.git
    ```
2. Change to the directory:
    ```bash
    cd CloudUploader_CLI
    ```
3. **Install the AWS CLI**:
    ```bash
    sudo apt-get install awscli  # For Ubuntu/Debian
    brew install awscli          # For macOS
    ```
4. **Install pv**:
    ```bash
    sudo apt-get install pv      # For Ubuntu/Debian
    brew install pv              # For macOS
    ```
5. Ensure your AWS CLI is configured with the necessary credentials:
    ```bash
    aws configure
    ```
6. Create an S3 bucket via the `AWS Console` or `AWS CLI`:

    https://www.youtube.com/watch?v=e6w9LwZJFIA

7. Make the script file executable:
    ```bash
    sudo chmod +x clouduploader.sh
    ```
## Usage
Basic Command
To upload a file to S3:
```bash
./clouduploader.sh /path/to/your/file.txt
```
## Options
- **Overwrite**: Replace an existing file in S3 with the new file.
- **Skip**: Do not upload the file if it already exists in S3.
- **Rename**: Upload the file with a new name, preserving the original extension.

**Examples**

### Upload a File
```bash
./clouduploader.sh /home/user/Downloads/lava.png
```
### Rename and Upload
If the file already exists:

```bash
File already exists in the cloud at your s3 location.
Choose an option:
1) Overwrite
2) Skip
3) Rename
Enter the number of your choice: 3
Enter a new name for the file: newfilename
```
### Generate a Shareable Link
After uploading, the tool generates a pre-signed URL that is valid for 1 hour:

```bash
Here is a shareable link valid for 1 hour: https://yourbucket.s3.amazonaws.com/yourfile.txt?....
```

## Troubleshooting
### Common Issues
- **AWS CLI not found**: Ensure the AWS CLI is installed and correctly configured.
- **Permission denied**: Make sure you have execute permissions for clouduploader.sh.
- **File not found**: Double-check the file path and ensure it exists.
- **Upload failed**: Verify your internet connection and AWS S3 permissions.