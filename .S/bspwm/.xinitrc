#!/bin/sh

export TERM=xterm
export EDITOR=nvim
export BROWSER=firefox

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

#if [ -f "$userresources" ]; then
#  xrdb -merge "$userresources"
#fi
#
#if [ -f "$usermodmap" ]; then
#  xmodmap "$usermodmap"
#fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

# set cursor
xsetroot -xcf /usr/share/icons/Vimix-cursors/cursors/left_ptr 40
# set speed
xset r rate 300 55
# launche picom
picom -f &
# set layout and config it
setxkbmap -option grp:alt_shift_toggle fr,ar
# Set wallpaper
nitrogen --restore
# Apply Xmodmap configs
xmodmap ~/.Xmodmap
# Apply Xresources configs
xrdb -merge ~/.Xresources
# Apply terminal theme
xrdb -override ~/xterm-themes/gruvbox-dark
xrdb -override ~/urxvt-themes/gruvbox-dark
# launche dunst
dunst -font "cascadiacode 12" &
# launche bspwm
exec bspwm
