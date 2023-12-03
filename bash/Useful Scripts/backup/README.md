<!-- omit in toc -->
# Backup

This script is used to backup files and folders under a hardcoded directory. 

It creates a `backup` folder under the `$HOME` directory and then creates a folder with the current date and time under the `backup` folder. 
It then copies the files and folders under a hardcoded directory (in the variable `$source_folder_path`) to the newly created folder in a `tar.gz` archive.