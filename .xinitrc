#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Auto start apps (fuck dwm auto start patch all my homies use xprofile because xinitrc was not starting the apps correctely) 
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

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

#qtile start

setxkbmap us intl 
xrandr --output HDMI-0 --mode 2560x1080 --rate 74.99
while type dwm >/dev/null ; do dwm && continue || break ; done
#xmonad
#i3
#wayfire
#instantwm
#9wm -term kitty

#session=${1:-qtile}

#case $session in
#    i3|i3wm           ) exec i3;;
#	dwm               ) exec dwm;; 
#    qtile        ) exec qtile start;;
    # No known session, try to run it as command
#    *                 ) exec $1;;
#esac
