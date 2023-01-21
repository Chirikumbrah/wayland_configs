#!/bin/bash


FONT="DejaVuSansMono:size=10" # dwm
# FONT="DejaVuSansMono:size=12.5" # i3wm
NORMBGCOLOR="#bd93f9"
NORMFGCOLOR="#282a36"
SELBGCOLOR="#50fa7b"
SELFGCOLOR="#282a36"
SHELL="/bin/bash"

case $1 in
    powermenu)
        SELECTED="$(echo -e "lock\n   exit\n   reboot\n   poweroff" | tofi)"


        if [ "$SELECTED" = "l" ] || [ "$SELECTED" = "lock" ] || [ "$SELECTED" = "д" ]; then
            notify-send "locking..." -u low
            sh "$HOME/.scripts/lock"
            sh "$HOME/.scripts/system/lock.sh"
        elif [ "$SELECTED" = "e" ] || [ "$SELECTED" = "exit" ] || [ "$SELECTED" = "у" ]; then
            dwm=$( ps -o pid,cmd ax | awk '/dwm/{ if ($2 == "dwm") print $1 }' )
            notify-send "exiting..." -u low
            [[ -n "$dwm" ]] && kill -s TERM "$dwm"

        elif [ "$SELECTED" = "r" ] || [ "$SELECTED" = "reboot" ] || [ "$SELECTED" = "к" ]; then
            notify-send "rebooting..." -u low
            sudo reboot
        elif [ "$SELECTED" = "s" ] || [ "$SELECTED" = "shutdown" ] || [ "$SELECTED" = "ы" ]; then
            notify-send "shutting down..." -u low
            sudo poweroff
        fi
    ;;
    apps)
        j4-dmenu-desktop --use-xdg-de --dmenu="(cat ; (stest -flx   \
            $(echo "$PATH" | tr : ' ') | sort -u))    | dmenu       \
            -fn '$FONT' -nb '$NORMBGCOLOR' -nf '$NORMFGCOLOR'       \
            -sb '$SELBGCOLOR' -sf '$SELFGCOLOR'"
    ;;
    clipmenu)
        clipmenu -fn "$FONT" -nb "$NORMBGCOLOR" -nf "$NORMFGCOLOR" -sb "$SELBGCOLOR" -sf "$SELFGCOLOR"
    ;;
esac
