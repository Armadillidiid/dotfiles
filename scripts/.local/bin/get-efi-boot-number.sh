#!/bin/bash

# Function to get the boot number from the boot name
BOOT_NAME="$1"

# Get the boot number (first match only - names like "Windows Boot Manager" can have multiple entries)
BOOT_NUMBER=$(efibootmgr | grep -m1 -P "\* ${BOOT_NAME}" | sed -E 's/^Boot([0-9A-Fa-f]+)\*.*/\1/')

# Check if boot number was found
if [ -z "$BOOT_NUMBER" ]; then
	echo "Boot name '$BOOT_NAME' not found!"
	exit 1
fi
echo "$BOOT_NUMBER"
