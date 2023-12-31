#!/bin/bash

# Set up git
git config --global user.name "Emmanuel Isenah"
git config --global user.email "emmanuelisenah@gmail.com"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --get user.name
git config --get user.email

# Create SSH Key
FILE=~/.ssh/id_ed25519.pub
if [ -f "$FILE" ]; then
    ssh-keygen -t ed25519 -C "emmanuelisenah@gmail"
    cat ~/.ssh/id_ed25519.pub
fi
