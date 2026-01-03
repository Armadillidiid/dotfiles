#!/bin/bash

# OBS to DaVinci Resolve Conversion Script
# Converts H.264/OPUS videos to DNxHR/PCM for DaVinci Resolve Free on Linux

set -euo pipefail

# Configuration
INPUT_FILE="$1"
OUTPUT_DIR="${HOME}/Videos/OBS-Resolve"
LOG_FILE="${HOME}/Videos/OBS-Resolve/conversion.log"

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

# Output file path
OUTPUT_FILE="${OUTPUT_DIR}/${FILENAME}.mov"

# Check if already converted
if [ -f "$OUTPUT_FILE" ]; then
    log_message "SKIP: Already converted: $BASENAME"
    exit 0
fi

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
}
trap cleanup EXIT

log_message "START: Converting $BASENAME"

# Convert with ffmpeg
# DNxHR HQ profile with yuv422p color space
# PCM signed 16-bit little-endian audio
if ffmpeg -i "$INPUT_FILE" \
    -c:v dnxhd \
    -profile:v dnxhr_hq \
    -pix_fmt yuv422p \
    -c:a pcm_s16le \
    -ar 48000 \
    "$OUTPUT_FILE" \
    >> "$LOG_FILE" 2>&1; then
    
    log_message "SUCCESS: Converted to $OUTPUT_FILE"
    
    # Optional: Add file size comparison
    INPUT_SIZE=$(du -h "$INPUT_FILE" | cut -f1)
    OUTPUT_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    log_message "INFO: Size comparison - Input: $INPUT_SIZE, Output: $OUTPUT_SIZE"
else
    log_message "ERROR: Conversion failed for $BASENAME"
    # Remove partial output file if it exists
    rm -f "$OUTPUT_FILE"
    exit 1
fi
