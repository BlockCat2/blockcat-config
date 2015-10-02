#!/bin/bash

#
# ~/.xinitrc
#
# Executed by startx

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" 
if [ -x /usr/bin/xdg-user-dirs-update ]; then
   /usr/bin/xdg-user-dirs-update
fi

userresources=$HOME/.Xresources

xrdb -load ~/.Xresources &
xbindkeys &
xsetroot -name "i3"


[ -z $(pgrep -xU $UID mpd) ] && mpd &

xset +fp /usr/share/fonts/bitmap
xset fp rehash
dunst &
xcompmgr &
exec i3

sh ~/.fehbg &


