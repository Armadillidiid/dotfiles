#!/bin/bash

# Function to get the boot number from the boot name
BOOT_NAME="$1"

# Get the boot number
BOOT_NUMBER=$(efibootmgr | grep -P "\* ${BOOT_NAME}" | awk '{print $1}' | tr -d '*Boot')

# Check if boot number was found
if [ -z "$BOOT_NUMBER" ]; then
	echo "Boot name '$BOOT_NAME' not found!"
	exit 1
fi
echo "$BOOT_NUMBER"
