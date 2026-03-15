#!/bin/sh

xrandr --output eDP-1 --primary --mode 1920x1200 --pos 0x244 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off --output DP-2 --off --output HDMI-3 --off --output DP-3 --off --output DP-4 --off --output DP-2-1 --off --output DP-2-1-5 --mode 1920x1080 --pos 4920x304 --rotate normal --output DP-2-1-6 --mode 1920x1080 --pos 1920x0 --rotate left --output DP-2-2 --mode 1920x1080 --pos 3000x304 --rotate normal --output DP-2-3 --off --output DVI-I-4-4 --off --output DVI-I-3-3 --off --output DVI-I-2-2 --off --output DVI-I-1-1 --off

# set -eu
#
# LAPTOP="eDP-1"
#
# LEFT_VERTICAL="DP-2-1-6"
# CENTER="DP-2-2"
# RIGHT="DP-2-1-5"
#
# is_connected() {
#   xrandr --query | grep -q "^$1 connected"
# }
#
# xrandr --output "$LAPTOP" --primary --mode 1920x1200 --pos 0x244 --rotate normal
#
# for output in HDMI-1 DP-1 HDMI-2 DP-2 HDMI-3 DP-3 DP-4 DP-2-1 DP-2-3 DVI-I-4-4 DVI-I-3-3 DVI-I-2-2 DVI-I-1-1; do
#   if xrandr --query | grep -q "^$output "; then
#     xrandr --output "$output" --off
#   fi
# done
#
# if is_connected "$LEFT_VERTICAL"; then
#   xrandr --output "$LEFT_VERTICAL" --mode 1920x1080 --rotate left --pos 1920x0
# fi
#
# if is_connected "$CENTER"; then
#   xrandr --output "$CENTER" --mode 1920x1080 --rotate normal --pos 3000x304
# fi
#
# if is_connected "$RIGHT"; then
#   xrandr --output "$RIGHT" --mode 1920x1080 --rotate normal --pos 4920x304
# fi
