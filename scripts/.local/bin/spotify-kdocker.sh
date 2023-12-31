#!/bin/bash
if [ "$(id -u)" = "0" ]; then
    echo "This script must be run as normal user" 1>&2
    exit 1
else

APP="/opt/spotify/spotify"

if ps ax | grep -v grep | grep $APP > /dev/null
    then
        echo "$APP application running, everything is fine" 1>&2
    else
        kdocker -q -o -l -i /usr/share/icons/hicolor/64x64/apps/spotify.png spotify %U
    fi
fi
