#!/usr/bin/env bash

set +e

# set up screen sharing, clipboard, keyring, and file pickers using XDG portals
/usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &

# wayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &


