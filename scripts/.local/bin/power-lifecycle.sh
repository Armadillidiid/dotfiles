#!/usr/bin/env bash

function close_apps() {
  FIREFOX=$(hyprctl clients | grep "class: firefox" | wc -l)

  if [ "$FIREFOX" -gt "1" ]; then
    notify-send "power controls" "Firefox multiple windows open"
    exit 1
  fi

  sleep 3

  # close all client windows
  # required for graceful exit since many apps aren't good SIGNAL citizens
  HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
  hyprctl --batch "$HYPRCMDS" >>/tmp/hypr/hyprexitwithgrace.log 2>&1

  notify-send "power controls" "Closing Applications..."

  sleep 2

  COUNT=$(hyprctl clients | grep "class:" | wc -l)
  if [ "$COUNT" -eq "0" ]; then
    notify-send "power controls" "Closed Applications."
    return
  else
    notify-send "power controls" "Some apps didn't close. Not shutting down."
    exit 1
  fi
}

function lock_screen() {
  hyprlock &
  sleep 1
}

case "$1" in
  shutdown)
    # close_apps
    hyprctl dispatch exit
    sleep 1
    systemctl poweroff
    ;;
  reboot)
    # close_apps
    hyprctl dispatch exit
    sleep 1
    systemctl reboot
    ;;

  suspend)
    lock_screen
    systemctl suspend
    ;;

  hibernate)
    lock_screen
    systemctl hibernate
    ;;

  logout)
    # close_apps
    hyprctl dispatch exit
    sleep 1
    loginctl kill-session "$XDG_SESSION_ID"
    ;;

  lock)
    lock_screen
    ;;

  close)
    close_apps
    ;;
  *)
    echo $"Usage: $0 {shutdown|reboot|suspend|hibernate|logout|lock|close}"
    exit 1
    ;;
esac