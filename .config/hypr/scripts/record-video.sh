#!/usr/bin/env bash

# if already recording → stop
if pgrep -x wf-recorder >/dev/null; then
  pkill -INT -x wf-recorder
  notify-send "Recording stopped"
  exit 0
fi

# countdown (optional but nice)
notify-send "Recording in 3..."
sleep 1
notify-send "2..."
sleep 1
notify-send "1..."
sleep 1

# start recording
file="$HOME/Videos/$(date +%Y-%m-%d_%H-%M-%S).mp4"

wf-recorder -f "$file" &

notify-send "Recording started"
