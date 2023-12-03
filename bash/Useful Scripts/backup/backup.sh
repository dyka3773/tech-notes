#!/usr/bin/bash

##########################################################################################
#
# Author: Ikons
# Date: 2023-8-10
# Version: 1.0
# Description: This script creates a backup of a specified folder.
#
##########################################################################################

# Variables
# Today's date
today=$(date +%Y-%m-%d_%H-%M-%S)
# The name of the backup file
backup_file_name="backup-$today.tar.gz"
# The path to the folder that the backup will be saved to
backup_target_folder_path="./backup"
# The path to the backup file
backup_file_path="$backup_target_folder_path/$backup_file_name"
# Folders to exclude from the backup
exculded_folders_file_path="$backup_target_folder_path/backup-exclude.txt"
# The path to the log file
log_file_path="$backup_target_folder_path/backup.log"
# The path to the folder that will be backed up
# NOTE: This is the most important variable, make sure you set it correctly
source_folder_path="$HOME" # TODO: This should be given as an argument

cd ~

# Functions
# Log a message
log_message() {
    if ! [ -d $backup_target_folder_path ]; then
        mkdir -p $backup_target_folder_path
        touch $log_file_path
    elif ! [ -f $log_file_path ]; then
        touch $log_file_path
    fi

    echo "$(date +%Y-%m-%d_%H:%M:%S) $1" >> $log_file_path
}

# Check if the backup file already exists
if [ -f $backup_file_path ]; then # NOTE: Modify this as you like
    log_message "WARNING: A backup file was already found with this name. Try again after the next interval or delete this file..."
    exit 1
fi

# If the exclude file exists, create the backup file excluding the folders in the exclude file
if [ -f $exculded_folders_file_path ]; then
    log_message "INFO: Creating the backup file..."
    tar -czf $backup_file_path -X $exculded_folders_file_path $source_folder_path 2>&1 | tee -a $log_file_path
else
    log_message "WARNING: The exclude file was not found. No files will be excluded from the backup..."
    log_message "INFO: Creating the backup file..."
    tar -czf $backup_file_path $source_folder_path 2>&1 | tee -a $log_file_path
fi

# Check if the backup file was created
if [ -f $backup_file_path ]; then
    log_message "INFO: The backup file was created successfully..."
else
    log_message "ERROR: The backup file was not created..."
    exit 1
fi