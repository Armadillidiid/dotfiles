#!/usr/bin/env bash
#
# reset-all-usb.sh
# Reset (unbind/bind) all USB host controllers.
# Usage: sudo ./reset-all-usb.sh

set -euo pipefail

# List of USB host-controller drivers to reset
drivers=(
  xhci_hcd   # USB3 + integrated USB2
  ehci-pci   # legacy USB2 (if separate)
  uhci_hcd   # legacy USB1
  ohci_hcd   # legacy USB1
)

for drv in "${drivers[@]}"; do
  drvpath="/sys/bus/pci/drivers/$drv"
  # skip non‑existing drivers
  [[ -d "$drvpath" ]] || continue

  echo ">> Processing USB driver: $drv"
  # find all bound PCI devices under this driver
  for devpath in "$drvpath"/0000:*; do
    # if glob didn't match, skip
    [[ -e "$devpath" ]] || continue
    dev_id=${devpath##*/}   # e.g. 0000:00:14.0

    printf "   - resetting %s (%s)… " "$dev_id" "$drv"
    # unbind then bind
    echo -n "$dev_id" > "$drvpath/unbind"
    # small pause to let device teardown
    sleep 0.1
    echo -n "$dev_id" > "$drvpath/bind"
    echo "done"
  done
done

echo "All USB host controllers have been reset."
