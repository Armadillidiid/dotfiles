#!/usr/bin/env bash
# find-usb-controller.sh  <bus> [port]
# e.g. find-usb-controller.sh 1      # root hub
#      find-usb-controller.sh 1 2    # port 2 on hub

BUS=$1
PORT=$2

SYSBUS=/sys/bus/usb/devices
if [[ -z $BUS || ! -d $SYSBUS/usb$BUS ]]; then
  echo "Usage: $0 <bus#> [port#]" >&2
  exit 1
fi

if [[ -n $PORT ]]; then
  TARGET=$SYSBUS/${BUS}-${PORT}
else
  TARGET=$SYSBUS/usb$BUS/device
fi

if [[ ! -e $TARGET ]]; then
  echo "Path $TARGET does not exist" >&2
  exit 2
fi

# climb up until we hit pciXXXX:YY:ZZ.Z
PCI_PATH=$(readlink -f $TARGET | sed -n 's@.*\(pci[0-9a-fA-F:]\+\).*@\1@p')
echo "USB bus $BUS${PORT:+ port $PORT} → PCI controller ${PCI_PATH#pci}"
