#!/bin/bash

echo -n "0000:05:00.4" | sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind
sleep 0.2
echo -n "0000:05:00.4" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind

