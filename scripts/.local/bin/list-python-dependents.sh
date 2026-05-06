#!/bin/bash

# List all foreign (AUR) packages that depend on python
pacman -Qqmd | while read pkg; do
    if pacman -Qi "$pkg" | grep -q "Depends On.*python"; then
        echo "$pkg"
    fi
done
