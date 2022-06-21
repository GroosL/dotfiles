#!/bin/sh

chosen=$(echo -e "Logout\nSuspend\nReboot\nShutdown" | rofi -dmenu -lines 5 -eh 2 -padding 850 -font "SF Pro Display 18" -p "Power Menu")

if [[ $chosen = "Logout" ]]; then
  ui=$(echo -e "Yes\nNo" | rofi -dmenu -lines 2 -eh 2 -padding 850 -font "SF Pro Display 18" -p "Logout ?")
  if [[ $ui = "Yes" ]]; then
  i3-msg exit
fi
elif [[ $chosen = "Shutdown" ]]; then
  ui=$(echo -e "Yes\nNo" | rofi -dmenu -lines 2 -eh 2 -padding 850 -font "SF Pro Display 18" -p "Shutdown ?")
  if [[ $ui = "Yes" ]]; then
  systemctl poweroff
fi
elif [[ $chosen = "Reboot" ]]; then
  ui=$(echo -e "Yes\nNo" | rofi -dmenu -lines 2 -eh 2 -padding 850 -font "SF Pro Display 18" -p "Reboot ?")
  if [[ $ui = "Yes" ]]; then
  systemctl reboot
fi	
elif [[ $chosen = "Suspend" ]]; then
  ui=$(echo -e "Yes\nNo" | rofi -dmenu -lines 2 -eh 2 -padding 850 -font "SF Pro Display 18" -p "Suspend ?")
  if [[ $ui = "Yes" ]]; then
  betterlockscreen -l dim  & systemctl suspend
fi	
elif [[ $chosen = "Hibernate" ]]; then
	systemctl hibernate
elif [[ $chosen = "Hybrid-sleep" ]]; then
	systemctl hibernate
elif [[ $chosen = "Suspend-then-hibernate" ]]; then
	systemctl suspend-then-hibernate
fi
