#!/bin/bash

sudo rfkill unblock bluetooth
sudo systemctl stop bluetooth
sudo systemctl status bluetooth
sudo systemctl restart bluetooth
