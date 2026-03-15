#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
if [ -f "$sysresources" ]; then
  xrdb -merge "$sysresources"
fi
if [ -f "$sysmodmap" ]; then
  xmodmap "$sysmodmap"
fi
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

# Start Xsession helper scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Export X env for user services
DISPLAY=${DISPLAY:-:0}
XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}
export DISPLAY XAUTHORITY
if command -v systemctl >/dev/null 2>&1; then
  systemctl --user import-environment DISPLAY XAUTHORITY
fi

# Reapply settings that may need rerun after hotplug
if [ -x "$HOME/.local/scripts/xsession-reapply" ]; then
  "$HOME/.local/scripts/xsession-reapply"
fi

# Tray, clipboard, audio, compositor, status bar
stalonetray --dockapp-mode simple &
clipmenud &
pulseaudio --start &
picom -f &
slstatus &

# Monitor change watcher
if command -v systemctl >/dev/null 2>&1; then
  systemctl --user enable --now xrandr-watch.service
fi

# Execute DWM
exec dwm
