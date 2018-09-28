#!/usr/bin/env sh

# Terminate existing instances
killall -q polybar

# Wait until processes are gone
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar(s)
MONITOR=LVDS1 polybar mainbar &

MONITOR=HDMI1 polybar mainbar &
