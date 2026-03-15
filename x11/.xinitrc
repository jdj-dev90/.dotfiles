userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard Layout
setxkbmap en_AU &
setxkbmap -option caps:escape &
xset r rate 200 35 &
stalonetray --dockapp-mode simple &

# Clipmenu
systemctl --user import-environment DISPLAY  &
clipmenud &

# Start audio server
pulseaudio --start

# Display Resolution
# ./.screenlayout/work_layout.sh
"$HOME/.screenlayout/home_layout.sh"

# Compositor
picom -f &

# Status Bar
slstatus &
rwp=$(find ~/.wallpapers/ -type f | shuf -n 1) 
/* exec wal -i ${rwp} & */

# Wallpaper
exec feh --bg-scale ${rwp} &

# Execute DWM
exec dwm

trap "killall picom clipmenud stalonetray" EXIT

