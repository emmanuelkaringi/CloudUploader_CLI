# CloudUploader
**A Simple CLI Tool for Uploading Files to AWS S3.**

![Cover Image](https://github.com/emmanuelkaringi/CloudUploader_CLI/blob/main/cover.jpeg)

## Overview

**CloudUploader** is a lightweight, bash-based command-line tool designed to streamline the process of uploading files to AWS S3. The tool offers an intuitive interface, allowing users to manage existing files on S3 with options to overwrite, skip, or rename. Additionally, it generates a pre-signed URL, making it easy to share your files securely.

## Prerequisites

Before using CloudUploader, ensure you have the following installed and configured:

- **AWS CLI** - Make sure the AWS CLI is installed and configured with your credentials. It is required for interacting with AWS S3 and AWS as a whole.
- **Bash Shell** - The script is written for a bash environment.
- **pv (Pipe Viewer)** - Used for showing upload progress.

## Installation
1. Clone the repository:
    ```bash
    git clone git@github.com:emmanuelkaringi/CloudUploader_CLI.git
    ```
2. Navigate to the directory:
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
6. Create an S3 bucket:
    - You can create an S3 bucket using the AWS Console or AWS CLI. Watch this [video tutorial](https://www.youtube.com/watch?v=e6w9LwZJFIA) if you're new to this process.

7. Make the script file executable:
    ```bash
    sudo chmod +x clouduploader.sh
    ```
## Usage
Basic Command
To upload a file to S3:
```bash
./clouduploader.sh
```
## Options
- **Overwrite**: Replace an existing file in S3 bucket with the new file.
- **Skip**: Do not upload the file if it already exists in the S3 Bucket.
- **Rename**: Upload the file with a new name, preserving the original extension.

**Examples**

### Upload a File
```bash
./clouduploader.sh
```
When prompted, provide the necessary details:

1. S3 bucket name
2. Optional target directory
3. File path

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

## Distribution

### Installation
To make CloudUploader easily accessible from anywhere in your terminal, you can install it by following these steps:

#### Method 1: Automated Installation

1. Make the installation script executable:
    ```bash
    chmod +x ./install.sh
    ```
2. Run the provided installation script:
    ```bash
    ./install.sh
    ```
3. The script will install CloudUploader to `/usr/local/bin`, making it accessible globally.

#### Method 2: Manual Installation

1. Copy the script to a directory in your `$PATH`, such as `/usr/local/bin`:
    ```bash
    sudo cp clouduploader.sh /usr/local/bin/clouduploader
    ```
2. Make the script executable:
    ```bash
    sudo chmod +x /usr/local/bin/clouduploader
    ```
3. Run the script from anywhere using:
    ```bash
    clouduploader
    ```

After installation, you can use `clouduploader` from anywhere in your terminal.

### Uninstallation

If you need to remove CloudUploader from your system, follow these steps:

#### Method 1: Automated Uninstallation

1. Make the uninstallation script executable:
    ```bash
    chmod +x ./uninstall.sh
    ``` 
2. Run the provided uninstallation script:
    ```bash
    ./uninstall.sh
    ```
3. The script will remove CloudUploader from `/usr/local/bin`.

#### Method 2: Manual Uninstallation

1. Remove the script from `/usr/local/bin` (or the directory where you installed it):
    ```bash
    sudo rm /usr/local/bin/clouduploader
    ```
2. Verify that the script has been removed:
    ```bash
    which clouduploader
    ```
- If no path is returned, the uninstallation was successful.

After uninstallation, the `clouduploader` command will no longer be available in your terminal.

## Troubleshooting
### Common Issues
- **AWS CLI not found**: Ensure the AWS CLI is installed and correctly configured.
- **Permission denied**: Make sure you have execute permissions for `clouduploader.sh`.
- **File not found**: Double-check the file path and ensure it exists.
- **Upload failed**: Verify your internet connection and AWS S3 permissions.
