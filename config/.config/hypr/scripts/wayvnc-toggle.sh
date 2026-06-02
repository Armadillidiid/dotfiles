#!/bin/bash

PORT=5900
ADDR="0.0.0.0"

if pgrep -x wayvnc >/dev/null; then
  pkill -x wayvnc
  notify-send "wayvnc" "Stopped"
else
  wayvnc -a -f 60 -g $ADDR $PORT >/tmp/wayvnc.log 2>&1 &
  sleep 0.5

  if ss -lnt | grep -q ":$PORT"; then
    notify-send "wayvnc" "Started on $ADDR:$PORT"
  else
    notify-send "wayvnc" "Failed to start (check log)"
  fi
fi
