#!/bin/sh
set -eu

LAPTOP="eDP-1"

LEFT_VERTICAL="DP-2-1-6"
CENTER="DP-2-2"
RIGHT="DP-2-1-5"

has_output() {
  xrandr --query | grep -q "^$1 "
}

is_connected() {
  xrandr --query | grep -q "^$1 connected"
}

if has_output "$LAPTOP"; then
  xrandr --output "$LAPTOP" --primary --mode 1920x1200 --pos 0x244 --rotate normal
fi

for output in HDMI-1 DP-1 HDMI-2 DP-2 HDMI-3 DP-3 DP-4 DP-2-1 DP-2-3 DVI-I-4-4 DVI-I-3-3 DVI-I-2-2 DVI-I-1-1; do
  if has_output "$output"; then
    xrandr --output "$output" --off
  fi
done

if is_connected "$LEFT_VERTICAL"; then
  xrandr --output "$LEFT_VERTICAL" --mode 1920x1080 --rotate left --pos 1920x0
fi

if is_connected "$CENTER"; then
  xrandr --output "$CENTER" --mode 1920x1080 --rotate normal --pos 3000x304
fi

if is_connected "$RIGHT"; then
  xrandr --output "$RIGHT" --mode 1920x1080 --rotate normal --pos 4920x304
fi
