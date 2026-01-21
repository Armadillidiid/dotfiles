#!/bin/bash

# OBS to DaVinci Resolve Conversion Script
# Converts videos to MPEG-4/PCM for DaVinci Resolve
# Watches OBS-Resolve folder and converts files copied there

set -euo pipefail

# Configuration
INPUT_FILE="$1"
OUTPUT_DIR=$(dirname "$INPUT_FILE")
LOG_DIR="${HOME}/Videos/.logs"
LOG_FILE="${LOG_DIR}/obs-resolve-conversion.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Validate input
if [ -z "${INPUT_FILE:-}" ]; then
	log_message "ERROR: No input file provided"
	exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
	log_message "ERROR: Input file does not exist: $INPUT_FILE"
	exit 1
fi

# Get file info
BASENAME=$(basename "$INPUT_FILE")
FILENAME="${BASENAME%.*}"
EXTENSION="${BASENAME##*.}"

# Only process video files
if [[ ! "$EXTENSION" =~ ^(mkv|mp4|mov|avi)$ ]]; then
	log_message "SKIP: Not a video file: $BASENAME"
	exit 0
fi

# Output file path (temp file first for safe conversion)
OUTPUT_FILE="${OUTPUT_DIR}/${FILENAME}.mov"
TEMP_OUTPUT="${OUTPUT_DIR}/.${FILENAME}.tmp.mov"

# Create a lock file to prevent multiple conversions of the same file
LOCK_FILE="${OUTPUT_DIR}/.${FILENAME}.lock"
if [ -f "$LOCK_FILE" ]; then
	log_message "SKIP: Conversion already in progress: $BASENAME"
	exit 0
fi

# Create lock file
touch "$LOCK_FILE"

# Cleanup function
cleanup() {
	rm -f "$LOCK_FILE"
	rm -f "$TEMP_OUTPUT"
}
trap cleanup EXIT

log_message "START: Converting $BASENAME"

# Convert with ffmpeg to temp file first
# MPEG-4 with quality 3 (lower is better, 1-31 scale)
# PCM signed 16-bit little-endian audio
if ffmpeg -i "$INPUT_FILE" \
	-c:v mpeg4 \
	-q:v 3 \
	-c:a pcm_s16le \
	-ar 48000 \
	"$TEMP_OUTPUT" \
	>>"$LOG_FILE" 2>&1; then

	# Move temp file to final location
	mv "$TEMP_OUTPUT" "$OUTPUT_FILE"

	log_message "SUCCESS: Converted to $OUTPUT_FILE"

	# File size comparison
	INPUT_SIZE=$(du -h "$INPUT_FILE" | cut -f1)
	OUTPUT_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
	log_message "INFO: Size comparison - Input: $INPUT_SIZE, Output: $OUTPUT_SIZE"

	# Delete the source file (copy in OBS-Resolve, not original in OBS)
	log_message "INFO: Deleting source file: $INPUT_FILE"
	rm -f "$INPUT_FILE"
	log_message "SUCCESS: Cleanup complete"
else
	log_message "ERROR: Conversion failed for $BASENAME"
	# Keep the source file on failure
	exit 1
fi
