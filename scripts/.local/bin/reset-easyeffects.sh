#!/bin/bash

killall -9 easyeffects;
sleep 1;
easyeffects &
disown
