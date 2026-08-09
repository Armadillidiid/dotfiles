#!/usr/bin/env bash
#
# ldm-mount.sh
# (Re)create the LDM (Windows dynamic disk) device-mapper volume and mount it.
# Needed after replugging the external drive: the kernel re-enumerates it
# (e.g. sda -> sdb) and the old /dev/mapper/ldm_vol_* mapping goes stale.
# Usage: sudo ./ldm-mount.sh   (or just ./ldm-mount.sh from a sudoers ALL user)

set -euo pipefail

VOL="ldm_vol_WINBOX-Dg0_Volume1"
MAPPER="/dev/mapper/$VOL"
MOUNTPOINT="/mnt/sda2"

# Already mounted -> nothing to do
if mountpoint -q "$MOUNTPOINT"; then
  echo ">> Already mounted at $MOUNTPOINT"
  findmnt "$MOUNTPOINT"
  exit 0
fi

# Drop a stale mapping (device may have been re-enumerated after replug)
if [[ -e "$MAPPER" ]]; then
  echo ">> Removing stale mapper $MAPPER"
  sudo dmsetup remove -f "$VOL"
fi

echo ">> Scanning for LDM volumes"
sudo ldmtool scan >/dev/null

echo ">> Recreating LDM volumes"
if ! sudo ldmtool create all | grep -q "$VOL"; then
  echo "ERROR: $VOL not created (is the drive plugged in?)." >&2
  exit 1
fi
echo "   $MAPPER created"

echo ">> Mounting $MAPPER at $MOUNTPOINT"
sudo mount "$MOUNTPOINT"
echo "   mounted"

findmnt "$MOUNTPOINT"
