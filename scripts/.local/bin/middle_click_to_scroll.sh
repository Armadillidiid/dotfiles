#!/bin/bash

# Get device IDs of all devices containing "pointer"
pointer_ids=($(xinput list | grep pointer | perl -p -e 's@.*?id=(\d+).*@\1@'))

for pointer_id in "${pointer_ids[@]}"; do
  if xinput list-props "$pointer_id" | grep "Razer" &>/dev/null; then
    # If the pointer supports scroll method, set middle click to scroll
    if xinput list-props "$pointer_id" | grep 'Scroll Method Enabled' &>/dev/null; then
      xinput set-prop "$pointer_id" 'libinput Scroll Method Enabled' 0 0 1
    fi
  fi
done

